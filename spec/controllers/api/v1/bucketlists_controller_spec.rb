require 'rails_helper'

RSpec.describe API::V1::BucketlistsController, type: :controller do
  render_views

  context "Valid User with Token" do
    before(:each) do
      request.headers['Authorization'] = "Token token=#{valid_user.token}"
    end

    it 'can get index with http status of 200' do
        send_request(:get, :index)

        expect(response).to have_http_status(200)
        expect(json.count).to eq Bucketlist.count

        sample_record = json.sample
        sample_record_bucketlist = Bucketlist.find(sample_record['id'])
        expect(sample_record.count).to be 2
        expect(sample_record_bucketlist.name).to eq sample_record['name']
    end

    it 'can get show with a valid token' do
      bucketlist = random_bucketlist
      send_request(:get, :show, {id: bucketlist.id})

      expect(response).to have_http_status(200)
      expect(json['name']).to eq bucketlist.name
      expect(json['items'].count).to eq bucketlist.items.count
    end

    it 'can create bucketlist with a valid token' do
      bucketlist_name = verb_ing
      send_request(:post, :create, { name: bucketlist_name })

      expect(response).to have_http_status(:created)
      expect(json['name']).to eq bucketlist_name
    end

    it 'can update a bucketlist' do
      bucketlist = usable_bucketlist
      new_bucketlist_name = verb_ing

      send_request(:put, :update, {id: bucketlist.id})

      expect(response).to have_http_status(:accepted)
      expect(json['name']).to eq bucketlist.reload.name
    end

    it 'cannot update a bucketlist that does not belong to current user' do
      bucketlist = random_bucketlist_that_does_not_belong_to_user
      new_bucketlist_name = verb_ing

      send_request(:put, :update, {id: bucketlist.id})

      expect(response).to have_http_status(:forbidden)
      expect(json['errors']).to eq invalid_access_to_resource_requested
    end

    it 'can delete a bucketlist' do
      bucketlist = usable_bucketlist

      send_request(:delete, :destroy, {id: bucketlist.id})

      expect(response).to have_http_status(:no_content)
    end

    it 'cannot delete a bucketlist that does not belong to a user' do
      bucketlist = random_bucketlist_that_does_not_belong_to_user

      send_request(:delete, :destroy, {id: bucketlist.id})

      expect(response).to have_http_status(:forbidden)
      expect(json['errors']).to eq invalid_access_to_resource_requested
    end
  end
end
