class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.string :direct_upload_url, null: false
      t.attachment :upload
      t.integer :status, default: 0, null: false
      t.timestamps null: false
    end
    add_index :documents, :status
  end
end
