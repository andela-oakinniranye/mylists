class API::V1::ItemsController < ApplicationController
  before_action :set_bucketlist

  def create
    @item = @bucketlist.items.build(item_params)
    params[:status].to_i == 1 ? @item.done! : @item.not_done!
    if @item.save
      render template: 'api/v1/bucketlists/show'
    else
      render json: @item.errors, status: :unprocessable_entity
    end
  end

  private
    def set_bucketlist
      @bucketlist = Bucketlist.find(params[:bucketlist_id])
    end

    def item_params
      params.permit(:name)
    end
end
