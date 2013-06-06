class Mandator < ActiveRecord::Base
  resourcify
  attr_accessible :name

  default_scope order('name asc')

  has_many :user, :order => :email
end
