class ChangesController < PaperTrailManager::ChangesController
  before_filter :authenticate_user!
  authorize_resource :class => false

  # Default number of changes to list on a pagenated index page.
  PER_PAGE = Wice::Defaults::PER_PAGE


  def index
    unless change_index_allowed?
      flash[:error] = "You do not have permission to list changes."
      return(redirect_to root_url)
    end

    versions = Version.order('created_at DESC, id DESC')
    if params[:type]
      versions = versions.where(:item_type => params[:type])
    end
    if params[:id]
      versions = versions.where(:item_id => params[:id])
    end

    @versions_grid = initialize_grid(versions)
  end

  def show
    super
  end

  def update
    super
  end

end
