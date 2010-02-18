class AddPaperclipPhotoToPerson < ActiveRecord::Migration
  def self.up
    add_column :people, :photo_file_name, :string
    add_column :people, :photo_content_type, :string
    add_column :people, :photo_file_size, :integer
    add_column :people, :photo_updated_at, :timestamp
  end

  def self.down
    [:photo_file_name, :photo_content_type, :photo_file_size, :photo_updated_at].each do |column_name|
      remove_column :people, column_name
    end
  end
end
