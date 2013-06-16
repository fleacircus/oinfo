class MessagesController < RestrictionController

  def index
    @messages_grid = initialize_grid(
      Message.accessible_by(current_ability),
      :order => 'messages.updated_at', :order_direction => 'desc'
    )
  end

end
