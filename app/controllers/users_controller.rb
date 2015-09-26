class UsersController < ApplicationController
  skip_before_action :authenticate, only: [:login]


  def login
    @current_user = User.find_or_create_by(login_params)
    @current_user.logged_in!
  end

  def logout
    @current_user.logged_out!
    render json: {message: "You were successfully logged out!"}
  end

  private
    def login_params
      params.permit(:email, :name)
    end
end
