class Accounting::CustomersController < RestrictionController
  @@export_include = [:user, :mandator]

  def index
    respond_to do |format|
      format.html {
        @customers_grid = initialize_grid(Customer.accessible_by(current_ability))
      }
      format.json {
        render json: Customer.accessible_by(current_ability), :include => @@export_include
      }
      format.xml {
        render xml: Customer.accessible_by(current_ability), :include => @@export_include
      }
    end
  end


  def show
    respond_to do |format|
      format.html
      format.json {
        render json: @customer, :include => @@export_include
      }
      format.xml {
        render xml: @customer, :include => @@export_include
      }
    end
  end

end
