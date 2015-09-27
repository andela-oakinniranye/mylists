require 'rails_helper'

RSpec.describe "API::V1::Users", type: :request do
  describe "GET /api_v1_users" do
    it "should log in a user" do
      make_request(:post, api_v1_login_path, valid_user_hash, nil)

      expect(response).to have_http_status(200)
      expect(json['token']).to eq valid_user.token
      expect(json['name']).to eq valid_user.name
      expect(json['email']).to eq valid_user.email
    end

    it 'should log out a user' do
      make_request(:get, api_v1_logout_path, nil, valid_user.token)

      expect(response).to have_http_status(200)
      expect(valid_user.logged_out?).to be true
    end

    it 'should not allow logged out user to access protected token' do
      token = valid_user.token
      make_request(:get, api_v1_logout_path, nil, token)

      make_request(:get, api_v1_bucketlist_path(random_bucketlist), nil, token)

      expect(response).to have_http_status(401)
      expect(json['errors']).to eq invalid_credentials_error
    end

    it 'should refresh a token when logged out and logged in' do
      token1 = valid_user.token
      make_request(:get, api_v1_logout_path, nil, token1)
      make_request(:post, api_v1_login_path, valid_user_hash, nil)
      token2 = valid_user.token

      expect(token1).not_to eq token2
    end
  end
end
