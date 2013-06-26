require 'test_helper'

class Accounting::InvoicesControllerTest < ActionController::TestCase
  setup do
    sign_in(users(:admin))
    @invoice = invoices(:one)
    @item    = invoice_items(:invoice_item_1)
  end

  test "should get index" do
    get :index
    assert_response :success
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
        invoice_number: @invoice.invoice_number+1,
        customer_id: @invoice.customer_id,
        distributor_id: @invoice.distributor_id,
        delivery_date: @invoice.delivery_date,
        value_date: @invoice.value_date,
        invoice_items_attributes: [{
          price: @item.price,
          currency: @item.currency,
          quantity: @item.quantity,
          name: @item.name,
          tax: @item.tax,
          benefit: @item.benefit,
          benefit_is_relative: @item.benefit_is_relative
        }]
      }
    end

    assert_redirected_to accounting_invoices_path
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
      invoice_number: @invoice.invoice_number+1,
      customer_id: @invoice.customer_id,
      distributor_id: @invoice.distributor_id,
      delivery_date: @invoice.delivery_date,
      value_date: @invoice.value_date
    }
    assert_redirected_to accounting_invoices_path
  end

  test "should destroy invoice" do
    assert_difference('Invoice.count', -1) do
      delete :destroy, id: @invoice
    end

    assert_redirected_to accounting_invoices_path
  end
end
