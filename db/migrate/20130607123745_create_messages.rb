class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string  :title, :null => false
      t.text    :text, :null => false
      t.integer :mandator_id
      t.integer :user_id

      t.timestamps
    end
    add_index :messages, :mandator_id
    add_index :messages, :user_id
  end
end
