class UsersController < ApplicationController
  skip_before_action :authenticate, only: [:login]


  def login
  end

  def logout

  end
end
