require 'test_helper'

class MediafilesControllerTest < ActionController::TestCase
  setup do
    @mediafile = mediafiles(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:mediafiles)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create mediafile" do
    assert_difference('Mediafile.count') do
      post :create, mediafile: { name: @mediafile.name, references: @mediafile.references }
    end

    assert_redirected_to mediafile_path(assigns(:mediafile))
  end

  test "should show mediafile" do
    get :show, id: @mediafile
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @mediafile
    assert_response :success
  end

  test "should update mediafile" do
    patch :update, id: @mediafile, mediafile: { name: @mediafile.name, references: @mediafile.references }
    assert_redirected_to mediafile_path(assigns(:mediafile))
  end

  test "should destroy mediafile" do
    assert_difference('Mediafile.count', -1) do
      delete :destroy, id: @mediafile
    end

    assert_redirected_to mediafiles_path
  end
end
