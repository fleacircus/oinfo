class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.integer :mandator_id
      t.integer :user_id
      t.integer :distributor_id, :null => false
      t.integer :customer_id, :null => false
      t.integer :invoice_number, :null => false
      t.date :invoice_date, :null => false
      t.date :delivery_date, :null => false
      t.date :value_date, :null => false

      t.timestamps
    end
    add_index :invoices, :mandator_id
    add_index :invoices, :user_id
    add_index :invoices, :distributor_id
    add_index :invoices, :customer_id
  end
end
