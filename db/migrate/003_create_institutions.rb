class CreateInstitutions < ActiveRecord::Migration
  def self.up
    transaction do
      create_table :institutions do |t|
        t.text         :name, :null => false
        t.references   :country, :null => false
        t.references   :state
        t.references   :parent, :class_name => 'Institution', :foreign_key => 'parent_id'
        t.references  :moduser, :class_name => "User", :foreign_key => 'moduser_id'
        t.timestamps
      end
    end
  end

  def self.down
    drop_table :institutions
  end
end
