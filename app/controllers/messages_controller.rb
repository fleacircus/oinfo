class MessagesController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  def index
    @messages_grid = initialize_grid(
      Message
    )
  end

  def show
    @message = Message.find(params[:id])
  end

  def new
    @message = Message.new
  end

  def edit
    @message = Message.find(params[:id])
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
    @message = Message.find(params[:id])

    @message.user_id = current_user.id
    @message.mandator_id = current_user.mandator_id

    if @message.update_attributes(params[:message])
        redirect_to messages_path, notice: flash_message('updated')
    else
        render action: "edit"
    end
  end

  def destroy
    @message = Message.find(params[:id])
    @message.destroy

    redirect_to messages_path, notice: flash_message('deleted')
  end

  private

  def flash_message(type)
    t('app.messages.'+type+'_model', :model => Message.model_name.human, :name => @message.id)
  end
end
