class ChangesController < PaperTrailManager::ChangesController
  before_filter :authenticate_user!
  authorize_resource :class => false


  def index
    unless change_index_allowed?
      return(redirect_to root_url), :error => t('paper_trail_manager.messages.permission_denied_list')
    end

    if params[:item_type] && params[:item_id]
      conditions = ['versions.item_type = ? AND versions.item_id = ?', params[:item_type], params[:item_id]]
    end

    @versions_grid = initialize_grid(
      Version,
      :conditions => conditions,
      :order => 'versions.created_at', :order_direction => 'desc'
    )
  end


  def show
    super
  end


  def update
    begin
      @version = Version.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      return(redirect_to(:action => :index)), :error => t('paper_trail_manager.messages.no_version')
    end

    unless change_revert_allowed?(@version)
      return(redirect_to :action => :index), :error => t('paper_trail_manager.messages.permission_denied_rollback')
    end

    if @version.event == "create"
      @record = @version.item_type.constantize.find(@version.item_id)
      @result = @record.destroy
    else
      @record = @version.reify
      @result = @record.save
    end

    if @result
      if @version.event == "create"
        redirect_to :action => :index, :notice => t('paper_trail_manager.messages.rollback_create')
      else
        redirect_to change_item_url(@version), :notice => t('paper_trail_manager.messages.rollback_update')
      end
    else
      redirect_to :action => :index, :error => t('paper_trail_manager.messages.rollback_failed')
    end
  end

end
