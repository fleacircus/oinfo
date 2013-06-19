class CorrectInvoiceItems < ActiveRecord::Migration
  def change
    change_column :invoice_items, :price,        :decimal, :precision => 12, :scale => 2, :null => false, :default => 0.00
    change_column :invoice_items, :tax,          :decimal, :precision => 5,  :scale => 2, :null => false, :default => 0.00
    change_column :invoice_items, :benefit,      :decimal, :precision => 12, :scale => 2, :null => false, :default => 0.00
    change_column :invoice_items, :net_amount,   :decimal, :precision => 12, :scale => 2, :null => false, :default => 0.00
    change_column :invoice_items, :gross_amount, :decimal, :precision => 12, :scale => 2, :null => false, :default => 0.00
  end
end
