class Invoice < ActiveRecord::Base
  attr_accessible :mandator_id, :user_id, :customer_id, :distributor_id,
                  :invoice_date, :invoice_number,
                  :delivery_date, :value_date,
                  :invoice_items_attributes

  belongs_to :user
  belongs_to :mandator
  belongs_to :customer
  belongs_to :distributor
  has_many   :invoice_items, :dependent => :destroy

  accepts_nested_attributes_for :invoice_items, :allow_destroy => true

  validates :customer_id, :presence => true
  validates :distributor_id, :presence => true
  validates :invoice_date, :presence => true
  validates :invoice_number, :presence => true
  validates :delivery_date, :presence => true
  validates :value_date, :presence => true
  validates :invoice_items, :length => { :minimum => 1 }

  has_paper_trail

  default_scope order('invoice_number asc')

end
