require 'test_helper'

class InvoicesControllerTest < ActionController::TestCase
  setup do
    @invoice = invoices(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:invoices)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create invoice" do
    assert_difference('Invoice.count') do
      post :create, invoice: {
        mandator_id: @invoice.mandator_id,
        user_id: @invoice.user_id,
        invoice_date: @invoice.invoice_date,
        invoice_number: @invoice.invoice_number,
        customer_id: @invoice.customer_id,
        distributor_id: @invoice.distributor_id,
        gross_amount: @invoice.gross_amount,
        net_amount: @invoice.net_amount,
        currency: @invoice.currency,
        delivery_date: @invoice.delivery_date,
        value_date: @invoice.value_date
      }
    end

    assert_redirected_to invoice_path(assigns(:invoice))
  end

  test "should show invoice" do
    get :show, id: @invoice
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @invoice
    assert_response :success
  end

  test "should update invoice" do
    put :update, id: @invoice, invoice: {
      mandator_id: @invoice.mandator_id,
      user_id: @invoice.user_id,
      invoice_date: @invoice.invoice_date,
      invoice_number: @invoice.invoice_number,
      customer_id: @invoice.customer_id,
      distributor_id: @invoice.distributor_id,
      gross_amount: @invoice.gross_amount,
      net_amount: @invoice.net_amount,
      currency: @invoice.currency,
      delivery_date: @invoice.delivery_date,
      value_date: @invoice.value_date
    }
    assert_redirected_to invoice_path(assigns(:invoice))
  end

  test "should destroy invoice" do
    assert_difference('Invoice.count', -1) do
      delete :destroy, id: @invoice
    end

    assert_redirected_to invoices_path
  end
end
