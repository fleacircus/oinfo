class AttachmentsController < ApplicationController
  before_filter :authenticate_user!
  authorize_resource

  def download
    name = "#{params[:basename]}.#{params[:extension]}"
    file = Attachment.where(:id => params[:id], :file => name).limit(1)

    begin
      send_file file[0].intern_url,
        :x_sendfile => true, :type => file[0].content_type, :filename => file[0].name
    rescue
      render :nothing => true, :status => 404
    end
  end

end
