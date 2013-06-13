class AddMandatorIdToVersion < ActiveRecord::Migration
  def change
    add_column :versions, :mandator_id, :integer
    add_index :versions, :mandator_id
  end
end
