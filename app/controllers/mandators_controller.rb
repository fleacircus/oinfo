class MandatorsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  def index
    @mandators_grid = initialize_grid(
      Mandator,
      :order => 'mandators.name', :order_direction => 'asc'
    )
  end

  def show
    @mandator = Mandator.find(params[:id])
  end

  def new
    @mandator = Mandator.new
  end

  def edit
    @mandator = Mandator.find(params[:id])
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
    @mandator = Mandator.find(params[:id])

    if @mandator.update_attributes(params[:mandator])
      redirect_to mandators_path, notice: flash_message('updated')
    else
      render action: "edit"
    end
  end

  def destroy
    @mandator = Mandator.find(params[:id])
    @mandator.destroy

    redirect_to mandators_path, notice: flash_message('deleted')
  end

  private

  def flash_message(type)
    t('app.messages.'+type+'_model', :model => Mandator.model_name.human, :name => @mandator.name)
  end
end
