class DashboardController < ApplicationController
  before_filter :authenticate_user!

  def index
    if current_user.has_role? :meta_admin
      @messages = Message
    else
      @messages = Message.where(:mandator_id => [nil, current_user.mandator_id])
    end

    @messages = @messages.limit(10).group_by { |m| m.updated_at.at_beginning_of_day }
  end
end
