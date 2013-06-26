require 'test_helper'

class Accounting::DistributorsControllerTest < ActionController::TestCase
  setup do
    sign_in(users(:admin))
    @distributor = distributors(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create distributor" do
    assert_difference('Distributor.count') do
      post :create, distributor: {
      mandator_id: @distributor.mandator_id,
      user_id: @distributor.user_id,
      name: @distributor.name,
      street: @distributor.street,
      city: @distributor.city,
      postal_code: @distributor.postal_code,
      country: @distributor.country,
      province: @distributor.province
    }
    end

    assert_redirected_to accounting_distributors_path
  end

  test "should show distributor" do
    get :show, id: @distributor
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @distributor
    assert_response :success
  end

  test "should update distributor" do
    put :update, id: @distributor, distributor: {
      mandator_id: @distributor.mandator_id,
      user_id: @distributor.user_id,
      name: @distributor.name,
      street: @distributor.street,
      city: @distributor.city,
      postal_code: @distributor.postal_code,
      country: @distributor.country,
      province: @distributor.province
    }
    assert_redirected_to accounting_distributors_path
  end

  test "should destroy distributor" do
    assert_difference('Distributor.count', -1) do
      delete :destroy, id: @distributor
    end

    assert_redirected_to accounting_distributors_path
  end
end
