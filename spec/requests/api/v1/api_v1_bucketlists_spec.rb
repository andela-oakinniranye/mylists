require 'rails_helper'

RSpec.describe "API::V1::Bucketlists", type: :request do

  let(:bucketlist){ random_bucketlist }
  let(:user){ valid_user }
  let(:token){ user.token }

  describe "GET /v1/bucketlists" do

    it "gets all the bucketlists" do
      make_request(:get, api_v1_bucketlists_path, nil, nil)

      expect(response).to have_http_status(200)
    end

    it 'can get single bucketlist when authenticated' do
      make_request(:get, api_v1_bucketlist_path(bucketlist), nil, token)

      expect(response).to have_http_status(200)
      expect(json['id']).to eq(bucketlist.id)
      expect(json['items'].count).to eq(bucketlist.items.count)
    end

    it 'cannot get a single bucketlist when not authenticated' do
      make_request(:get, api_v1_bucketlist_path(bucketlist), nil, nil)

      expect(response).to have_http_status(401)
      expect(json['errors']).to eq invalid_credentials_error
    end

    it 'can create new bucketlists when authenticated' do
      make_request(:post, api_v1_bucketlists_path, {name: 'Konzing'}, token)

      new_bucketlist = Bucketlist.last
      expect(json['id']).to eq new_bucketlist.id
      expect(json['name']).to eq new_bucketlist.name
      expect(json['created_by']).to eq new_bucketlist.user_id
    end

    it 'cannot create a new bucketlists when not authenticated' do
      make_request(:post, api_v1_bucketlists_path, {name: 'Konzing'}, nil)

      expect(response).to have_http_status(401)
      expect(json['errors']).to eq invalid_credentials_error
    end

    it 'can create new bucketlist item when authenticated' do
      item_name1 = smart_word
      item_name2 = smart_word

      expect{
        make_request(:post, api_v1_bucketlist_items_path(bucketlist), {name: item_name1, status: 0}, token)
      }.to change(Item, :count).by(1)
      expect(bucketlist.items.last.name).to eq item_name1
      expect(bucketlist.items.last.done?).to be false

      expect{
        make_request(:post, api_v1_bucketlist_items_path(bucketlist), {name: item_name2, status: 1}, token)
      }.to change(Item, :count).by(1)
      expect(bucketlist.items.last.name).to eq item_name2
      expect(bucketlist.items.last.done?).to be true
    end

    it 'cannot create a new bucketlist item when not authenticated' do
      item_name = smart_word
      make_request(:post, api_v1_bucketlist_items_path(bucketlist), {name: item_name, status: 0}, nil)

      expect(response).to have_http_status(401)
      expect(json['errors']).to eq invalid_credentials_error
    end

    it 'can update a bucketlist when authenticated' do
      new_name = verb_ing
      bucketlist = usable_bucketlist
      make_request(:put, api_v1_bucketlist_path(bucketlist), {name: new_name, user: user}, token)

      expect(response).to have_http_status(:accepted)
      expect(bucketlist.reload.name).to eq(new_name)
    end

    it 'cannot update a bucketlist when not authenticated' do
      new_name = verb_ing
      make_request(:put, api_v1_bucketlist_path(bucketlist), {name: new_name, user: user}, nil)

      expect(response).to have_http_status(401)
      expect(json['errors']).to eq invalid_credentials_error
    end

    it 'cannot update a bucketlist that belongs to another user' do
      bucketlist = random_bucketlist_that_does_not_belong_to_user
      new_name = verb_ing

      make_request(:put, api_v1_bucketlist_path(bucketlist), {name: new_name, user: user}, token)

      expect(response).to have_http_status(:forbidden)
      expect(json['errors']).to eq invalid_access_to_resource_requested
    end

    it 'can delete a bucketlist when authenticated' do
      bucketlist = usable_bucketlist
      expect{
        make_request(:delete, api_v1_bucketlist_path(bucketlist), nil, token)
      }.to change(Bucketlist, :count).by(-1)

      expect{
        make_request(:get, api_v1_bucketlist_path(bucketlist), nil, token)
      }.to raise_error(ActiveRecord::RecordNotFound)
    end

    it 'cannot delete a bucketlist when not authenticated' do
      make_request(:delete, api_v1_bucketlist_path(bucketlist), nil, nil)

      expect(response).to have_http_status(401)
      expect(json['errors']).to eq invalid_credentials_error
    end

    it 'cannot delete a bucketlist that belongs to another user' do
      bucketlist = random_bucketlist_that_does_not_belong_to_user

      make_request(:delete, api_v1_bucketlist_path(bucketlist), nil, token )

      expect(response).to have_http_status(:forbidden)
      expect(json['errors']).to eq invalid_access_to_resource_requested
    end
  end
end
