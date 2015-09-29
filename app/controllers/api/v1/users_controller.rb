class API::V1::UsersController < ApplicationController
  skip_before_action :authenticate, except: [:logout]

  def login
    @current_user = User.find_by_email(user_params[:email])
    if @current_user && @current_user.authenticate(user_params[:password])
      @current_user.logged_in!
    else
      invalid_credentials and return
    end
  end

  def logout
    @current_user.logged_out!
    render json: {message: "You were successfully logged out!"}, status: 200
  end

  def create
    @user = User.new(user_params)

    if @user.save
      head :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  private
    def user_params
      params.permit(:email, :name, :password)
    end

    def invalid_credentials
      render json: {errors: "Either your username and password don't match or you don't have an account"}, status: :forbidden
    end
end
