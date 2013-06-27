class Message < ActiveRecord::Base
  restricted_model

  attr_accessible :text, :title

  validates :title, :presence => true
  validates :text,  :presence => true

  default_scope order('updated_at desc')
end
