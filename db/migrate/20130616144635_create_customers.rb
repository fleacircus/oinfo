class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.integer :mandator_id
      t.integer :user_id
      t.string :name
      t.string :street
      t.integer :postal_code
      t.string :city
      t.string :province
      t.string :country

      t.timestamps
    end
    add_index :customers, :mandator_id
    add_index :customers, :user_id
  end
end
