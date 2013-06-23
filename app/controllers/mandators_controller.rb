class MandatorsController < RestrictionController
  @@export_include = :user

  def index
    respond_to do |format|
      format.html {
        @mandators_grid = initialize_grid(
          Mandator, :include => :user,
          :order  => 'mandators.name', :order_direction => 'asc'
        )
      }
      format.json {
        render json: Mandator.accessible_by(current_ability).to_json(:include => @@export_include)
      }
      format.xml {
        render xml: Mandator.accessible_by(current_ability).to_xml(:include => @@export_include)
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
        render json: @mandator.to_json(:include => @@export_include)
      }
      format.xml {
        render json: @mandator.to_xml(:include => @@export_include)
      }
    end
  end

end
