require 'test_helper'

class API::V1::BucketlistsControllerTest < ActionController::TestCase
  setup do
    @bucketlist = bucketlists(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:bucketlists)
  end

  test "should create bucketlist" do
    assert_difference('Bucketlist.count') do
      post :create, bucketlist: {name: 'Sampling' }
    end

    assert_response 201
  end

  test "should show bucketlist" do
    get :show, id: @bucketlist
    assert_response :success
  end

  test "should update bucketlist" do
    put :update, id: @bucketlist, bucketlist: {  }
    assert_response 204
  end

  test "should destroy bucketlist" do
    assert_difference('Bucketlist.count', -1) do
      delete :destroy, id: @bucketlist
    end

    assert_response 204
  end

  # test "can create new item" do
  #   # get :create
  #   create_params = {name: Faker::Hacker.say_something_smart, status: 0 }
  #   post :create,  create_params
  #   require 'pry' ; binding.pry
  #   item = JSON.parse(response.body)
  #   assert_response :success
  # end
end
