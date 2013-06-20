class InvoiceItem < ActiveRecord::Base
  attr_accessible :invoice_id, :name, :price, :currency, :quantity,
                  :benefit, :benefit_is_relative, :tax

  belongs_to :invoice, :touch => true

  validates :name, :presence => true
  validates :price, :presence => true, :numericality => true
  validates :currency, :presence => true
  validates :quantity, :presence => true, :numericality => { :only_integer => true }
  validates :tax, :presence => true, :numericality => {:greater_than_or_equal_to => 0, :less_than_or_equal_to => 100}
  validates :benefit, :presence => true, :numericality => true

  has_paper_trail

  before_save :calculate_amounts

  private

  def calculate_amounts
    n = self.price * self.quantity
    g = n * (1 + self.tax / 100)
    b = self.benefit

    if self.benefit_is_relative == true
      g *= 1 - b / 100
    else
      g -= b
    end

    self.net_amount   = n
    self.gross_amount = g
  end

end
