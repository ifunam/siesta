class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.references :user, :null => false
      t.references :user_request
      t.string :subject
      t.text :body
      t.references :parent, :class_name => "Comment", :foreign_key => 'parent_id'
      t.references :moduser, :class_name => "User", :foreign_key => 'moduser_id'
      t.timestamps
    end
  end

  def self.down
    drop_table :comments
  end
end
