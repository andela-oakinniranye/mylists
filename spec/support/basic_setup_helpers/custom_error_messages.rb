module CustomErrorMessages
  def invalid_credentials_error
    "Bad Credentials. Log in at #{api_v1_login_url} to obtain a valid token"
  end

  def invalid_access_to_resource_requested
    "You are not the owner of the resource you are trying to modify"
  end

  def invalid_user_message
    "Either your username and password don't match or you don't have an account"
  end

  def unmatched_routes_message
    "The resource you are trying to access does not exist"
  end
end
