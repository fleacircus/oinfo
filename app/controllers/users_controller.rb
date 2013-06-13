class UsersController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  autocomplete :mandator, :name


  def index
    if current_user.has_role? :meta_admin
      conditions = ['users.id != ?', current_user.id]
    else
      conditions = ['users.id != ? AND users.mandator_id == ?', current_user.id, current_user.mandator_id]
    end

    @users_grid = initialize_grid(
      User, :include => :mandator,
      :conditions => conditions,
      :order => 'users.email', :order_direction => 'asc',
      :custom_order => {
        'users.mandator_id' => 'mandators.name'
      }
    )
  end


  def new
    @user = User.new
  end


  def create
    @user = User.new(params[:user])

    if !current_user.has_role? :meta_admin
      @user.mandator_id = current_user.mandator_id
    end

    if @user.save
      redirect_to users_path, notice: flash_message('created')
    else
      render :action => 'new'
    end
  end


  def update
    if params[:user][:password].blank?
      params[:user].delete("password")
      params[:user].delete("password_confirmation")
    end

    if !current_user.has_role? :meta_admin
      params[:user].delete('role_ids')
      params[:user].delete('mandator_id')
    end

    if @user.update_attributes(params[:user])
      if @user.id == current_user.id
        sign_in @user, :bypass => true
        redirect_to root_path, notice: t('app.messages.updated_account')
      else
        redirect_to users_path, notice: flash_message('updated')
      end
    else
      render :action => 'edit'
    end
  end


  def destroy
    if @user.id == current_user.id
        redirect_to users_path, alert: t('app.messages.delete_account_impossible')
    elsif @user.destroy
        redirect_to users_path, notice: flash_message('deleted')
    end
  end


  private

  def flash_message(type)
    t('app.messages.'+type+'_model', :model => User.model_name.human, :name => @user.email)
  end
end
