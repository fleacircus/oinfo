class MandatorsController < RestrictionController

  def index
    @mandators_grid = initialize_grid(
      Mandator, :include => :user,
      :order  => 'mandators.name', :order_direction => 'asc'
    )
  end


  def show
    @users_grid = initialize_grid(
      User,
      :conditions => ['users.id != ? AND users.mandator_id == ?', current_user.id, params[:id]],
      :order => 'users.email', :order_direction => 'asc'
    )
  end

end
