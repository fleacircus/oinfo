class Accounting::CustomersController < RestrictionController

  def index
    @customers_grid = initialize_grid(Customer.accessible_by(current_ability))
  end

end
