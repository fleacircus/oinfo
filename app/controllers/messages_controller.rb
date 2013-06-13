class MessagesController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource


  def index
    messages = Message
    if !current_user.has_role? :meta_admin
      messages = messages.where(:mandator_id => [nil, current_user.mandator_id])
    end

    @messages_grid = initialize_grid(
      messages,
      :order => 'messages.updated_at', :order_direction => 'desc'
    )
  end


  def new
    @message = Message.new
  end


  def create
    @message = Message.new(params[:message])

    @message.user_id = current_user.id
    @message.mandator_id = current_user.mandator_id

    if @message.save
      redirect_to messages_path, notice: flash_message('created')
    else
      render action: "new"
    end
  end


  def update
    @message.user_id = current_user.id
    @message.mandator_id = current_user.mandator_id

    if @message.update_attributes(params[:message])
        redirect_to messages_path, notice: flash_message('updated')
    else
        render action: "edit"
    end
  end


  def destroy
    @message.destroy

    redirect_to messages_path, notice: flash_message('deleted')
  end


  private

  def flash_message(type)
    t('app.messages.'+type+'_model', :model => Message.model_name.human, :name => @message.title)
  end
end
