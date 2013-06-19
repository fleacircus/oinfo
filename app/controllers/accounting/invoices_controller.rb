class Accounting::InvoicesController < RestrictionController

  def index
    @invoices_grid = initialize_grid(
      Invoice.accessible_by(current_ability),
      :include => [:customer, :distributor, :invoice_items],
      :custom_order => {
        'invoices.customer_id'    => 'customers.name',
        'invoices.distributor_id' => 'distributors.name'
      }
    )
  end

end
