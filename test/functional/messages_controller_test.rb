require 'test_helper'

class MessagesControllerTest < ActionController::TestCase
  setup do
    sign_in(users(:admin))
    @message = messages(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create message" do
    assert_difference('Message.count') do
      post :create, message: { mandator_id: @message.mandator_id, text: @message.text, title: @message.title, user_id: @message.user_id }
    end

    assert_redirected_to messages_path
  end

  test "should show message" do
    get :show, id: @message
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @message
    assert_response :success
  end

  test "should update message" do
    put :update, id: @message, message: { mandator_id: @message.mandator_id, text: @message.text, title: @message.title, user_id: @message.user_id }
    assert_redirected_to messages_path
  end

  test "should destroy message" do
    assert_difference('Message.count', -1) do
      delete :destroy, id: @message
    end

    assert_redirected_to messages_path
  end
end
