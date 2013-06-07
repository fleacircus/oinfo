class DashboardController < ApplicationController
  before_filter :authenticate_user!

  def index
    @messages = Message.all.group_by { |m| m.updated_at.at_beginning_of_day }
  end
end
