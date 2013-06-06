class CreateMandators < ActiveRecord::Migration
  def change
    create_table :mandators do |t|
      t.string :name

      t.timestamps
    end

    add_index :mandators, :name, :unique => true
  end
end
