class MandatorsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource


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


  def create
    @mandator = Mandator.new(params[:mandator])

    if @mandator.save
      redirect_to mandators_path, notice: flash_message('created')
    else
      render action: "new"
    end
  end


  def update
    if @mandator.update_attributes(params[:mandator])
      redirect_to mandators_path, notice: flash_message('updated')
    else
      render action: "edit"
    end
  end


  def destroy
    @mandator.destroy

    redirect_to mandators_path, notice: flash_message('deleted')
  end


  private

  def flash_message(type)
    t('app.messages.'+type+'_model', :model => Mandator.model_name.human, :name => @mandator.name)
  end
end
