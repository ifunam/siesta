class CreateDocuments < ActiveRecord::Migration
  def self.up
    transaction do

      create_table :documents do |t|
        t.text     :name, :null => false
        t.references :moduser, :class_name => "User", :foreign_key => 'moduser_id'
        t.timestamps
      end
      add_index :documents, [:name], :name => :documents_name_key, :unique => true
    end
  end

  def self.down
    drop_table :documents
  end
end
