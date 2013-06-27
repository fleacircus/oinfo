class Accounting::DistributorsController < RestrictedAccess::Controller
  EXPORT_INCLUDE = [:user, :mandator]

  def index
    respond_to do |format|
      format.html {
        @distributors_grid = initialize_grid(Distributor.accessible_by(current_ability))
      }
      format.json {
        render json: Distributor.accessible_by(current_ability), :include => EXPORT_INCLUDE
      }
      format.xml {
        render xml: Distributor.accessible_by(current_ability), :include => EXPORT_INCLUDE
      }
    end
  end


  def show
    respond_to do |format|
      format.html
      format.json {
        render json: @distributor, :include => EXPORT_INCLUDE
      }
      format.xml {
        render xml: @distributor, :include => EXPORT_INCLUDE
      }
    end
  end

end
