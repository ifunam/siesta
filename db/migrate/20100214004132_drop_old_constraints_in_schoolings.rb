class DropOldConstraintsInSchoolings < ActiveRecord::Migration
  def self.up
	execute "ALTER TABLE schoolings ALTER COLUMN file_old DROP NOT NULL"
	execute "ALTER TABLE schoolings ALTER COLUMN content_type DROP NOT NULL"
	execute "ALTER TABLE schoolings ALTER COLUMN filename DROP NOT NULL"
  end

  def self.down
  	execute "ALTER TABLE schoolings ALTER COLUMN file_old SET NOT NULL"
  	execute "ALTER TABLE schoolings ALTER COLUMN content_type SET NOT NULL"
  	execute "ALTER TABLE schoolings ALTER COLUMN filename SET NOT NULL"
  end
end
