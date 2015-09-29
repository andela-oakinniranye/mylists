module MakeRequest
  def make_request(type, path, options=nil, auth_token={})
    auth = auth_token.blank? ? {} : {authorization: "Token token=#{auth_token}"}
    self.send(type, path, options, auth)
  end
end
