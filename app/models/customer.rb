class Customer < ActiveRecord::Base
  attr_accessible :name,  :street, :postal_code, :city, :province,:country,
                  :mandator_id, :user_id

  belongs_to :user
  belongs_to :mandator
  has_many :invoice

  validates :name, :presence => true
  validates :street, :presence => true
  validates :postal_code, :presence => true, :numericality => { :only_integer => true }
  validates :city, :presence => true
  validates :country, :presence => true

  has_paper_trail

  default_scope order('name asc')
end
