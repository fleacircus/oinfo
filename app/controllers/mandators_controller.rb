class MandatorsController < RestrictedAccess::Controller
  EXPORT_INCLUDE = :users

  def index
    respond_to do |format|
      format.html {
        @mandators_grid = initialize_grid(
          Mandator, :include => :users,
          :order  => 'mandators.name', :order_direction => 'asc'
        )
      }
      format.json {
        render json: Mandator.accessible_by(current_ability), :include => EXPORT_INCLUDE
      }
      format.xml {
        render xml: Mandator.accessible_by(current_ability), :include => EXPORT_INCLUDE
      }
    end
  end


  def show
    respond_to do |format|
      format.html {
        @users_grid = initialize_grid(
          User,
          :conditions => ['users.id != ? AND users.mandator_id == ?', current_user.id, params[:id]],
          :order => 'users.email', :order_direction => 'asc'
        )
      }
      format.json {
        render json: @mandator, :include => EXPORT_INCLUDE
      }
      format.xml {
        render json: @mandator, :include => EXPORT_INCLUDE
      }
    end
  end

end
