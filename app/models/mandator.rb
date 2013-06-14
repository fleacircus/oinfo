class Mandator < ActiveRecord::Base
  resourcify
  attr_accessible :name

  validates :name, :presence => true

  has_many :user, :order => :email
  has_many :message

  has_paper_trail

  default_scope order('name asc')
end
