class UsersController < ApplicationController
  load_and_authorize_resource

  def index
    @users_grid = initialize_grid(
      User.where('id != ?', current_user.id),
      :order => 'users.email',
      :order_direction => 'desc'
    )
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = "Successfully created #{@user.email}."
      redirect_to users_path
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
      if (@user.id == current_user.id)
        flash[:notice] = "Successfully updated your account."
        sign_in @user, :bypass => true
        redirect_to root_path
      else
        flash[:notice] = "Successfully updated #{@user.email}."
        redirect_to users_path
      end
    else
      render :action => 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      flash[:notice] = "Successfully deleted #{@user.email}."
      redirect_to users_path
    end
  end

end
