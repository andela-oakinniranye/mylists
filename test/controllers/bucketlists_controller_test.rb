require 'test_helper'

class BucketlistsControllerTest < ActionController::TestCase
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
      post :create, bucketlist: {  }
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
end
