class Mandator < ActiveRecord::Base
  attr_accessible :name

  validates :name, :presence => true

  has_many :users, :order => :email
  has_many :messages
  has_many :distributors
  has_many :customers
  has_many :addresses
  has_many :invoices

  has_paper_trail

  default_scope order('name asc')
end
