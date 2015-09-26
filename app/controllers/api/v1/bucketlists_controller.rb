class API::V1::BucketlistsController < ApplicationController
  before_action :set_bucketlist, only: [:show, :update, :destroy]
  skip_before_action :authenticate, only: [:index]

  def index
    @bucketlists = Bucketlist.all
  end

  def show
  end

  def create
    @bucketlist = Bucketlist.new(bucketlist_params)
    if @bucketlist.save
      render json: @bucketlist, status: :created, location: api_v1_bucketlist_url(@bucketlist)
    else
      render json: @bucketlist.errors, status: :unprocessable_entity
    end
  end

  def update
    @bucketlist = Bucketlist.find(params[:id])
    if @bucketlist.update(bucketlist_params)
      head :no_content
    else
      render json: @bucketlist.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @bucketlist.destroy
    head :no_content
  end

  private
    def set_bucketlist
      @bucketlist = Bucketlist.find(params[:id])
    end

    def bucketlist_params
      params.permit(:name)
    end
end
