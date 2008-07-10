class CreatePhotos < ActiveRecord::Migration
  def self.up
    create_table :photos do |t|
      t.binary :file
      t.string :filename
      t.string :content_type
      t.references :user, :null => false
      t.references :moduser, :class_name => "User", :foreign_key => 'moduser_id'
      t.timestamps
    end
  end

  def self.down
    drop_table :photos
  end
end
