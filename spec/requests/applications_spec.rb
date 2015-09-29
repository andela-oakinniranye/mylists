require 'rails_helper'

RSpec.describe "Applications", type: :request do
  describe "GET /" do
    it "should intercept calls to unmatched routes" do
      make_request(:get, '/kion', nil, valid_user.token)

      expect(response).to have_http_status(400)
      expect(json['errors']).to eq unmatched_routes_message
    end
  end
end
