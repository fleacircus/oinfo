require 'test_helper'

class MandatorsControllerTest < ActionController::TestCase
  setup do
    sign_in(users(:admin))
    @mandator = mandators(:mandator_2)
  end

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create mandator" do
    assert_difference('Mandator.count') do
      post :create, mandator: { name: "New created #{@mandator.name}" }
    end

    assert_redirected_to mandators_path
  end

  test "should show mandator" do
    get :show, id: @mandator
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @mandator
    assert_response :success
  end

  test "should update mandator" do
    put :update, id: @mandator, mandator: { name: @mandator.name }
    assert_redirected_to mandators_path
  end

  test "should destroy mandator" do
    assert_difference('Mandator.count', -1) do
      delete :destroy, id: @mandator
    end

    assert_redirected_to mandators_path
  end
end
