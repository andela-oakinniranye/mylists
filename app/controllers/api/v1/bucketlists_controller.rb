class API::V1::BucketlistsController < ApplicationController
  before_action :set_bucketlist, only: [ :update, :destroy]
  before_action :set_bucketlist_with_items, only: [:show]
  before_action :check_that_current_user_owns_the_bucketlist, only: [:update, :destroy]
  skip_before_action :authenticate, only: [:index]

  def index
    @bucketlists = Bucketlist.all
  end

  def show
  end

  def create
    @bucketlist = Bucketlist.new(bucketlist_params)
    if @bucketlist.save
      render template: 'api/v1/bucketlists/show', status: :created, location: api_v1_bucketlist_path(@bucketlist)
    else
      render json: @bucketlist.errors, status: :unprocessable_entity
    end
  end

  def update
    if @bucketlist.update(bucketlist_params)
      render template: 'api/v1/bucketlists/show', status: :accepted
    else
      render json: @bucketlist.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @bucketlist.destroy
    head :no_content
  end

  private
    def set_bucketlist_with_items
      @bucketlist = Bucketlist.fetch_bucketlists_with_items.find(params[:id])
    end

    def set_bucketlist
      @bucketlist = Bucketlist.find(params[:id])
    end

    def check_that_current_user_owns_the_bucketlist
      unless @bucketlist.user == @current_user
        alert_unauthorized_access_to_bucketlist and return
      end
    end

    def alert_unauthorized_access_to_bucketlist
        render json: {errors: "You are not the owner of the resource you are trying to modify"}, status: :forbidden
    end

    def bucketlist_params
      params.permit(:name).merge(user: @current_user)
    end
end
