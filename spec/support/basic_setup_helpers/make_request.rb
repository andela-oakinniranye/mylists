module MakeRequest
  def make_request(type, path, options=nil, auth_token={})
    auth = auth_token.blank? ? {} : {authorization: "Token token=#{auth_token}"}
    self.send(type, path, options, auth)
  end

  def invalid_credentials_error
    # expect(response).to have_http_status(401)
    # expect(json['errors']).to eq invalid_credentials_error
    "Bad Credentials. Log in at #{api_v1_login_url} to obtain a valid token"
  end
end
