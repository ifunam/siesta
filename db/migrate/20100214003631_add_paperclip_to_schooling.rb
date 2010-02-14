class AddPaperclipToSchooling < ActiveRecord::Migration
	def self.up
   		rename_column :schoolings, :file, :file_old
	 	add_column :schoolings, :file_file_name, :string
	 	add_column :schoolings, :file_content_type, :string
	 	add_column :schoolings, :file_file_size, :integer
	 	add_column :schoolings, :file_updated_at, :timestamp
	end

	def self.down
		[:file_file_name, :file_content_type, :file_file_size, :file_updated_at].each do |column_name|
			remove_column :schoolings, column_name
		end
		rename_column :schoolings, :file_old, :file
	end
end
