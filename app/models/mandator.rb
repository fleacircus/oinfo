class Mandator < ActiveRecord::Base
  attr_accessible :name

  validates :name, :presence => true

  has_many :user, :order => :email
  has_many :message
  has_many :distributor
  has_many :customer
  has_many :address
  has_many :invoice

  has_paper_trail

  default_scope order('name asc')
end
