class UsersController < ApplicationController
  before_filter :authenticate_user!
  authorize_resource

  autocomplete :mandator, :name

  @@export_include = :mandator

  def index
    respond_to do |format|
      format.html {
        @users_grid = initialize_grid(
          User.accessible_by(current_ability),
          :include => :mandator,
          :order => 'users.email', :order_direction => 'asc',
          :custom_order => {
            'users.mandator_id' => 'mandators.name'
          }
        )
      }
      format.json {
        render json: User.accessible_by(current_ability).to_json(:include => @@export_include)
      }
      format.xml {
        render xml: User.accessible_by(current_ability).to_xml(:include => @@export_include)
      }
    end
  end


  def show
    if !(@user = find_by_id_or_redirect(User)).nil?
      respond_to do |format|
        format.html
        format.json {
          render json: @user.to_json(:include => @@export_include)
        }
        format.xml {
          render xml: @user.to_xml(:include => @@export_include)
        }
      end
    end
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
      redirect_to_with_flash users_path, :notice, 'create_instance', User, @user.email
    else
      render :action => 'new'
    end
  end


  def edit
    @user = find_by_id_or_redirect(User, params[:id] || current_user)
  end


  def update
    @user = find_by_id_or_redirect(User)

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
        redirect_to_with_flash root_path, :notice, 'update_account'
      else
        redirect_to_with_flash users_path, :notice, 'update_instance', User, @user.email
      end
    else
      render :action => 'edit'
    end
  end


  def destroy
    @user = find_by_id_or_redirect(User)

    if @user.id == current_user.id
        redirect_to_with_flash users_path, :alert, 'destroy_account_impossible'
    elsif @user.destroy
        redirect_to_with_flash users_path, :notice, 'destroy_instance', User, @user.email
    end
  end

end
