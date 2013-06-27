class AttachmentsController < RestrictedAccess::Controller

  def download
    name = "#{params[:basename]}.#{params[:extension]}"
    file = Attachment.where(:id => params[:id], :file => name).limit 1

    if cannot? :download, file
      download_failed 403 # Maybe better 404 for security reasons!?
      return
    end

    begin
      send_file file[0].intern_url,
        :x_sendfile => true, :type => file[0].content_type, :filename => file[0].name
    rescue
      download_failed 404
    end
  end


  private

  def download_failed(status)
      render :nothing => true, :status => status
  end

end
