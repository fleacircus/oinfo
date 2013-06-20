class Attachment < ActiveRecord::Base
  attr_accessible :name, :file

  belongs_to :attachable

  mount_uploader :file, FileUploader

  before_save :check_name

  private

  def check_name
    self.name = self.file.filename if self.name == ''
  end

end
