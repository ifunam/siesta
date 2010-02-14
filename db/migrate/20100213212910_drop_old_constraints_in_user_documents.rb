class DropOldConstraintsInUserDocuments < ActiveRecord::Migration
  def self.up
	execute "ALTER TABLE user_documents ALTER COLUMN file_old DROP NOT NULL"
	execute "ALTER TABLE user_documents ALTER COLUMN content_type DROP NOT NULL"
	execute "ALTER TABLE user_documents ALTER COLUMN filename DROP NOT NULL"
  end

  def self.down
    execute "ALTER TABLE user_documents ALTER COLUMN file_old SET NOT NULL"
    execute "ALTER TABLE user_documents ALTER COLUMN content_type SET NOT NULL"
    execute "ALTER TABLE user_documents ALTER COLUMN filename SET NOT NULL"
  end
end
