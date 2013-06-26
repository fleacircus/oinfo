require 'test_helper'

class Accounting::CustomersControllerTest < ActionController::TestCase
  setup do
    sign_in(users(:admin))
    @customer = customers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create customer" do
    assert_difference('Customer.count') do
      post :create, customer: {
        mandator_id: @customer.mandator_id,
        user_id: @customer.user_id,
        name: @customer.name,
        street: @customer.street,
        city: @customer.city,
        postal_code: @customer.postal_code,
        country: @customer.country,
        province: @customer.province
      }
    end

    assert_redirected_to accounting_customers_path
  end

  test "should show customer" do
    get :show, id: @customer
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @customer
    assert_response :success
  end

  test "should update customer" do
    put :update, id: @customer, customer: {
      mandator_id: @customer.mandator_id,
      user_id: @customer.user_id,
      name: @customer.name,
      street: @customer.street,
      city: @customer.city,
      postal_code: @customer.postal_code,
      country: @customer.country,
      province: @customer.province
    }
    assert_redirected_to accounting_customers_path
  end

  test "should destroy customer" do
    assert_difference('Customer.count', -1) do
      delete :destroy, id: @customer
    end

    assert_redirected_to accounting_customers_path
  end
end
