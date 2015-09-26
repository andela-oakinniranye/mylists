require 'test_helper'

class API::V1::ItemsControllerTest < ActionController::TestCase
  test "can create new item" do
    # get :create
    create_params = {name: Faker::Hacker.say_something_smart, status: 0, bucketlist_id: Bucketlist.last.to_param }
    post :create,  create_params
    require 'pry' ; binding.pry
    item = JSON.parse(response.body)
    assert_response :success
  end

end
