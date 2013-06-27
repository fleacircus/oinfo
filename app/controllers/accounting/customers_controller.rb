class Accounting::CustomersController < RestrictedAccess::Controller
  EXPORT_INCLUDE = [:user, :mandator]

  def index
    respond_to do |format|
      format.html {
        @customers_grid = initialize_grid(Customer.accessible_by(current_ability))
      }
      format.json {
        render json: Customer.accessible_by(current_ability), :include => EXPORT_INCLUDE
      }
      format.xml {
        render xml: Customer.accessible_by(current_ability), :include => EXPORT_INCLUDE
      }
    end
  end


  def show
    respond_to do |format|
      format.html
      format.json {
        render json: @customer, :include => EXPORT_INCLUDE
      }
      format.xml {
        render xml: @customer, :include => EXPORT_INCLUDE
      }
    end
  end

end
