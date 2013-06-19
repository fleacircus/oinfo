class Accounting::DistributorsController < RestrictionController

  def index
    @distributors_grid = initialize_grid(Distributor.accessible_by(current_ability))
  end

end
