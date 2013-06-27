class Distributor < ActiveRecord::Base
  restricted_model

  attr_accessible :name,  :street, :postal_code, :city, :province,:country

  has_many :invoices

  validates :name, :presence => true
  validates :street, :presence => true
  validates :postal_code, :presence => true, :numericality => { :only_integer => true }
  validates :city, :presence => true
  validates :country, :presence => true

  default_scope order('name asc')
end
