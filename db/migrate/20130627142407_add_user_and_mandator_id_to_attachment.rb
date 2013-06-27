class AddUserAndMandatorIdToAttachment < ActiveRecord::Migration
  def change
    add_column :attachments, :user_id, :integer
    add_column :attachments, :mandator_id, :integer
    add_index :attachments, :user_id
    add_index :attachments, :mandator_id
  end
end
