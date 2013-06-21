class Attachment < ActiveRecord::Base
  attr_accessible :name, :file

  belongs_to :attachable, :polymorphic => true, :touch => true

  mount_uploader :file, FileUploader

  before_save :update_attributes

  has_paper_trail

  private

  def update_attributes
    if file.present? && file_changed?
      self.content_type = file.file.content_type
      self.file_size    = file.file.size
      self.name         = file.file.filename if self.name == ''
    end
  end

end
