class ExtractUserDocumentToFileSystem < ActiveRecord::Migration
  def self.up
	UserDocument.all.each do |record|
	  if !record.file_old.nil? and !record.content_type.nil? and !record.filename.nil?
		dest_dir = [Rails.root.to_s, 'public/system/files', record.id, 'original'].join('/')
		unless File.exists? dest_dir
			puts "Creating dir #{dest_dir}"
			system "mkdir -p #{dest_dir}"
		end
		if File.directory? dest_dir
		    file_path = File.join(dest_dir, record.filename)
		 	puts "Extracting #{file_path}  "
		    File.open(file_path, "w") do |f|
		       f.write record.file_old
		    end
		    record.file_file_name = record.filename
		    record.file_content_type = record.content_type
			record.file_file_size = File.size(file_path)
			record.file_updated_at = Time.now
			record.save
		end
	  end
	end
  end

  def self.down
	UserDocument.all.each do |record|
		if !record.file_old.nil? and !record.content_type.nil? and !record.filename.nil?
			dest_dir = [Rails.root.to_s, 'public/system/files', record.id].join('/')
			puts "Deleting directory #{dest_dir}"
			system "rm -rf #{dest_dir}"
		end
	end

  end
end
