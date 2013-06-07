class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :title
      t.text :text
      t.integer :mandator_id
      t.integer :user_id

      t.timestamps
    end
    add_index :messages, :mandator_id
    add_index :messages, :user_id
  end
end
