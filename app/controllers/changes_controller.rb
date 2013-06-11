class ChangesController < PaperTrailManager::ChangesController
  before_filter :authenticate_user!


  def index
    super
  end

  def show
    super
  end

  def update
    super
  end

end
