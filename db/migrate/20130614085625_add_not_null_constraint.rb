class AddNotNullConstraint < ActiveRecord::Migration
  def change
    change_column :mandators, :name,  :string, :null => false

    change_column :messages,  :title, :string, :null => false
    change_column :messages,  :text,  :text,   :null => false
  end
end
