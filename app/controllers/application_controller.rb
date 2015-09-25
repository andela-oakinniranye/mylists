class ApplicationController < ActionController::API
  # include ActionController::Serialization
  include ActionController::HttpAuthentication::Token::ControllerMethods
  include ActionController::ImplicitRender
  include ActionController::Helpers
  helper BucketlistsHelper

  attr_reader :current_user

  before_action :authenticate

  private
    def default_serializer_options
      {root: false }
    end

    def authenticate
      authenticate_token || unauthorized_token
    end

    def authenticate_token
      authenticate_with_http_token do |auth_token, options|
        current_user= User.find_by_token(auth_token)
      end
    end

    def unauthorized_token
      self.headers['WWW-Authenticate'] = 'Token realm="Application"'
      render json: {error: 'Bad Credentials'}, status: 401
    end
end
