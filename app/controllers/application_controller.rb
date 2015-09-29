class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods
  include ActionController::ImplicitRender
  include ActionController::Helpers

  helper BucketlistsHelper
  before_action :authenticate

  def no_route_found
    render json: {errors: "The resource you are trying to access does not exist"}, status: 400
  end

  private
    def authenticate
      authenticate_token || unauthorized_token
    end

    def authenticate_token
      authenticate_with_http_token do |auth_token, options|
        @current_user = User.logged_in.find_by_token(auth_token)
      end
    end

    def unauthorized_token
      self.headers['WWW-Authenticate'] = 'Token realm="Application"'
      render json: {errors: "Bad Credentials. Log in at #{api_v1_login_url} to obtain a valid token"}, status: 401
    end
end
