class UsersController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  autocomplete :mandator, :name

  def index
    @users_grid = initialize_grid(
      User.where('id != ?', current_user.id),
      :order => 'users.email', :order_direction => 'asc'
    )
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to users_path, notice: flash_message('created')
    else
      render :action => 'new'
    end
  end

  def edit
    @user = User.find(params[:id] || current_user)
  end

  def update
    if params[:user][:password].blank?
      params[:user].delete("password")
      params[:user].delete("password_confirmation")
    end

    @user = User.find(params[:id])
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
    @user = User.find(params[:id])
    if @user.id == current_user.id
        redirect_to users_path, alert: t('app.message.delete_account_impossible')
    elsif @user.destroy
        redirect_to users_path, notice: flash_message('deleted')
      end
  end

  private

  def flash_message(type)
    t('app.messages.'+type+'_model', :model => User.model_name.human, :name => @user.email)
  end

end