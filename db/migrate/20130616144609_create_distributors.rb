class CreateDistributors < ActiveRecord::Migration
  def change
    create_table :distributors do |t|
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
    add_index :distributors, :mandator_id
    add_index :distributors, :user_id
  end
end
