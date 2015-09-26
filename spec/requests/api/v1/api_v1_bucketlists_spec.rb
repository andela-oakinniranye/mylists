require 'rails_helper'

RSpec.describe "API::V1::Bucketlists", type: :request do
  before(:each) do
    User.destroy_all
    User.reset_pk_sequence
  end

  let(:bucketlist){ Bucketlist.limit(1).offset(rand(Bucketlist.count)).first}
  let(:user){ user = User.create!(name: 'ikem', email: 'ikem@andela.com'); user.logged_in!; user }

  describe "GET /v1/bucketlists" do
    it "gets all the bucketlists" do
      get api_v1_bucketlists_path
      expect(response).to have_http_status(200)
    end

    it 'gets single bucketlist' do
      make_request(:get, api_v1_bucketlist_path(bucketlist), nil, user.token)
      expect(response).to have_http_status(200)
      expect(json['id']).to eq(bucketlist.id)
      expect(json['items'].count).to eq(bucketlist.items.count)
    end

    it 'creates new bucketlists' do
      make_request(:post, api_v1_bucketlists_path, {name: 'Konzing'}, user.token)
      new_bucketlist = Bucketlist.last

      expect(json['id']).to eq new_bucketlist.id
    end

    it 'creates new bucketlist item' do
      item_count = bucketlist.items.count
      item_name1 = Faker::Hacker.say_something_smart
      item_name2 = Faker::Hacker.say_something_smart

      make_request(:post, api_v1_bucketlist_path(bucketlist), {name: item_name1, status: 0}, user.token)

      expect(bucketlist.items.count).to eq item_count + 1
      expect(bucketlist.items.last.name).to eq item_name1
      expect(bucketlist.items.last.done?).to be false

      make_request(:post, api_v1_bucketlist_path(bucketlist), {name: item_name2, status: 1}, user.token)
      expect(bucketlist.items.count).to eq item_count + 2
      expect(bucketlist.items.last.name).to eq item_name2
      expect(bucketlist.items.last.done?).to be true
    end

    it 'can update a bucketlist' do
      new_name = 'Cooling Koning Hugging'
      make_request(:put, api_v1_bucketlist_path(bucketlist), {name: new_name}, user.token)
      expect(response).to have_http_status(204)
      expect(bucketlist.reload.name).to eq(new_name)
    end

    it 'can delete a bucketlist' do
      expect{
        make_request(:delete, api_v1_bucketlist_path(bucketlist), nil, user.token)
      }.to change(Bucketlist, :count).by(-1)

      expect{
        make_request(:get, api_v1_bucketlist_path(bucketlist), nil, user.token)
      }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
