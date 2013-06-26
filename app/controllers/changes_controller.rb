class ChangesController < ApplicationController
  before_filter :authenticate_user!
  authorize_resource :version, :parent => false


  def index
    conditions = {}

    if !current_user.mandator_id.nil?
      conditions = {:mandator_id => current_user.mandator_id}
    end

    if !params[:item_type].nil? && !params[:item_id].nil?
      if !params[:item_type].safe_constantize.nil? && params[:item_id].to_i != 0
        conditions[:item_type] = params[:item_type]
        conditions[:item_id]   = params[:item_id]
      else
        params.delete :item_type
        params.delete :item_id

        redirect_to_with_flash changes_path, :notice, 'not_found_instance', Version
        return
      end
    end

    @versions_grid = initialize_grid(
      Version,
      :conditions => conditions,
      :order => 'versions.created_at', :order_direction => 'desc'
    )
  end


  def show
    @version = find_by_id_or_redirect(Version)
  end


  def update
    @version = find_by_id_or_redirect(Version)

    if @version.event == "create"
      begin
        @record = @version.item_type.constantize.find(@version.item_id)
      rescue ActiveRecord::RecordNotFound
        redirect_to changes_path, alert: t('app.version.record_not_exists')
        return
      end
      @result = @record.destroy
    else
      @record = @version.reify
      @result = @record.save
    end

    if @result
      if @version.event == "create"
        redirect_to changes_path, notice: t('app.version.rollback_create')
      else
        redirect_to change_item_url(@version), notice: t('app.version.rollback_update')
      end
    else
      redirect_to changes_path, alert: t('app.version.rollback_failed')
    end
  end


  protected

  def change_item_path(version)
    path = "#{version.item_type.downcase}_path"
    if ['Invoice', 'InvoiceItem', 'Customer', 'Distributor', 'Attachment'].include? version.item_type
      path = "accounting_#{path}"
    end
    return send(path, version.item_id)
  rescue NoMethodError
    return nil
  end
  helper_method :change_item_path

end
