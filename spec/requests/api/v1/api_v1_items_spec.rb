require 'rails_helper'

RSpec.describe "API::V1::Items", type: :request do
  describe "creates new items" do

    let(:bucketlist){ random_bucketlist }
    let(:user){ valid_user }

    it "can create a new item when authenticated" do
      name = smart_word

      make_request(:post, api_v1_bucketlist_items_path(bucketlist), {name: name}, user.token)

      last_item = json['items'].last
      expect(last_item['name']).to eq name

      expect(response).to have_http_status(:created)
    end

    it "cannot create a new item when not authenticated" do
      name = smart_word

      make_request(:post, api_v1_bucketlist_items_path(bucketlist), {name: name}, nil)

      expect(response).to have_http_status(401)
      expect(json['errors']).to eq invalid_credentials_error
    end
  end
end
