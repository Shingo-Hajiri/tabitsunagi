class AddRecordIdToActiveStorageAttachments < ActiveRecord::Migration[7.1]
  def change
    add_column :active_storage_attachments, :record_id, :bigint, null: false unless column_exists?(:active_storage_attachments, :record_id)
  end
end
