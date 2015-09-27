class API::V1::UsersController < ApplicationController
  skip_before_action :authenticate, only: [:login, :create]

  def login
    @current_user = User.find_by_email(user_params[:email])
    if @current_user.authenticate(user_params[:password])
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
      head :no_content
    else
      render json: @user.errors, status: 403
    end
  end

  private
    def user_params
      params.permit(:email, :name, :password)
    end

    def invalid_credentials
      render json: {errors: "Your username and password don't match"}, status: 401
    end
end
