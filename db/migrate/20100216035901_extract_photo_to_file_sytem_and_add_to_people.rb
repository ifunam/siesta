class ExtractPhotoToFileSytemAndAddToPeople < ActiveRecord::Migration
  def self.up
    if Rails.env != 'test'
      Photo.all.each do |record|
        if !record.file.nil? and !record.content_type.nil? and !record.filename.nil?
          @person = Person.find_by_user_id(record.user_id)        
          unless @person.nil?
            dest_dir = [Rails.root.to_s, 'public/system/photos', @person.id, 'card'].join('/')
            unless File.exists? dest_dir
              puts "Creating dir #{dest_dir}"
              system "mkdir -p #{dest_dir}"
            end
            if File.directory? dest_dir
              file_path = File.join(dest_dir, record.filename)
              puts "Extracting #{file_path}  "
              File.open(file_path, "w") do |f|
                f.write record.file
              end
              @person.photo_file_name = record.filename
              @person.photo_content_type = record.content_type
              @person.photo_file_size = File.size(file_path)
              @person.photo_updated_at = record.updated_at || Time.now
              @person.save
            end
          end
        end
      end 
    end
  end

  def self.down
    if Rails.env != 'test'

      Photo.all.each do |record|
        if !record.file.nil? and !record.content_type.nil? and !record.filename.nil?
          dest_dir = [Rails.root.to_s, 'public/system/photos', record.id, 'card'].join('/')
          file_path = File.join(dest_dir, record.filename)
          puts "Deleting file #{file_path}"
          system "rm -rf #{file_path}"
        end
      end
    end
  end
end
