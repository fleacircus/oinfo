class Message < ActiveRecord::Base
  attr_accessible :mandator_id, :text, :title, :user_id

  validates :title, :presence => true
  validates :text,  :presence => true

  belongs_to :user
  belongs_to :mandator

  has_paper_trail

  default_scope order('updated_at desc')
end
