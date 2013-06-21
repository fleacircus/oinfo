class AttachmentsController < ApplicationController
  before_filter :authenticate_user!
  authorize_resource

  def download
    name = "#{params[:basename]}.#{params[:extension]}"
    file = Attachment.where(:id => params[:id], :file => name).limit(1)

    if file.count > 0
      send_file Rails.root.join('uploads', file[0].file.file.file),
        :x_sendfile => true, :type => file[0].content_type, :filename => file[0].name
    else
      raise ActionController::RoutingError.new('Not Found')
    end
  end

end
