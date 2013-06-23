class Accounting::DistributorsController < RestrictionController
  @@export_include = [:user, :mandator]

  def index
    respond_to do |format|
      format.html {
        @distributors_grid = initialize_grid(Distributor.accessible_by(current_ability))
      }
      format.json {
        render json: Distributor.accessible_by(current_ability), :include => @@export_include
      }
      format.xml {
        render xml: Distributor.accessible_by(current_ability), :include => @@export_include
      }
    end
  end


  def show
    respond_to do |format|
      format.html
      format.json {
        render json: @distributor, :include => @@export_include
      }
      format.xml {
        render xml: @distributor, :include => @@export_include
      }
    end
  end

end
