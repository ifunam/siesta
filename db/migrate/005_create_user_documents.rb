class CreateUserDocuments < ActiveRecord::Migration
  def self.up
    transaction do
      create_table :user_documents do |t|
        t.references :user, :document, :null => false
        t.binary  :file, :null => false
        t.text    :filename, :content_type, :null => false
        t.references :moduser, :class_name => "User", :foreign_key => 'moduser_id'
        t.timestamps
      end
    end
  end

  def self.down
    drop_table :user_documents
  end
end
