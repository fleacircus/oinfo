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
        redirect_to changes_path, alert: t('paper_trail_manager.messages.no_version_found')
        return
      end
    end

    logger.info "--\nconditions: #{conditions}\n--"

    @versions_grid = initialize_grid(
      Version,
      :conditions => conditions,
      :order => 'versions.created_at', :order_direction => 'desc'
    )
  end


  def show
    begin
      @version = Version.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      redirect_to changes_path, alert: t('paper_trail_manager.messages.no_version_found')
    end
  end


  def update
    begin
      @version = Version.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      redirect_to changes_path, alert: t('paper_trail_manager.messages.no_version_found')
      return
    end

    logger.info @version.inspect

    if @version.event == "create"
      begin
        @record = @version.item_type.constantize.find(@version.item_id)
      rescue ActiveRecord::RecordNotFound
        redirect_to changes_path, alert: t('paper_trail_manager.messages.record_not_exists')
        return
      end
      @result = @record.destroy
    else
      @record = @version.reify
      @result = @record.save
    end

    if @result
      if @version.event == "create"
        redirect_to changes_path, notice: t('paper_trail_manager.messages.rollback_create')
      else
        redirect_to change_item_url(@version), notice: t('paper_trail_manager.messages.rollback_update')
      end
    else
      redirect_to changes_path, alert: t('paper_trail_manager.messages.rollback_failed')
    end
  end


  protected

  def change_item_url(version)
    return send("#{version.item_type.downcase}_url", version.item_id)
  rescue NoMethodError
    return nil
  end
  helper_method :change_item_url

end
