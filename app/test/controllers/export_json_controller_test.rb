require 'test_helper'

class ExportJsonControllerTest < ActionController::TestCase
  test "should get users" do
    get :users
    assert_response :success
  end

  test "should get museums" do
    get :museums
    assert_response :success
  end

  test "should get collections" do
    get :collections
    assert_response :success
  end

  test "should get items" do
    get :items
    assert_response :success
  end

end
