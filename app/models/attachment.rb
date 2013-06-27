class Attachment < ActiveRecord::Base
  restricted_model
  mount_uploader :file, FileUploader

  attr_accessible :name, :file, :remote_file_url

  belongs_to :attachable, :polymorphic => true, :touch => true

  before_save :update_attributes


  def intern_url
    Rails.root.join('uploads', self.file.file.file)
  end

  def public_url
    "/files/#{self.id}/#{File.basename(self.file_url)}"
  end

  private

  def update_attributes
    if file.present? && file_changed?
      self.content_type = file.file.content_type
      self.file_size    = file.file.size
      self.name         = file.file.filename if self.name == ''
    end
  end

end
