class CreateInvoiceItems < ActiveRecord::Migration
  def change
    create_table :invoice_items do |t|
      t.integer :invoice_id
      t.decimal :price, :precision => 10, :scale => 2, :null => false, :default => 0.00
      t.string :currency
      t.integer :quantity, :null => false, :default => 0
      t.string :name, :null => false
      t.decimal :tax, :precision => 3, :scale => 2, :null => false, :default => 0.00
      t.decimal :benefit, :precision => 10, :scale => 2, :null => false, :default => 0.00
      t.boolean :benefit_is_relative, :null => false, :default => false
      t.decimal :net_amount, :precision => 10, :scale => 2, :null => false, :default => 0.00
      t.decimal :gross_amount, :precision => 10, :scale => 2, :null => false, :default => 0.00

      t.timestamps
    end
    add_index :invoice_items, :invoice_id
  end
end
