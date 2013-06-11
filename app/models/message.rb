class Message < ActiveRecord::Base
  resourcify
  attr_accessible :mandator_id, :text, :title, :user_id

  belongs_to :user
  belongs_to :mandator

  has_paper_trail

  default_scope order('updated_at desc')
end
