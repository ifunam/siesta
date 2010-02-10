class CreateSchoolings < ActiveRecord::Migration
  def self.up
    #transaction do
      create_table :degrees do |t|
        t.text     :name, :null => false
        t.references :moduser, :class_name => "User", :foreign_key => 'moduser_id'
        t.timestamps
      end

      create_table :schools do |t|
         t.text     :name, :null => false
         t.references :institution, :null => false
         t.references :moduser, :class_name => "User", :foreign_key => 'moduser_id'
         t.timestamps
      end

      create_table :careers do |t|
          t.text     :name, :null => false
          t.references  :degree, :school, :null => false
          t.references :moduser, :class_name => "User", :foreign_key => 'moduser_id'
          t.timestamps
      end

      create_table :schoolings do |t|
#        t.references :user, :career,:null => false
        t.references :user, :degree, :null => false
        t.string :career, :school, :institution, :null => false
        t.integer :startyear, :null => false
        t.integer :endyear, :credits  
        t.string  :studentid                                   
        t.float   :average,  :null => false
        t.boolean :is_studying_this, :default => true, :null => false
        t.boolean :is_titleholder, :default => false, :null => false
        t.binary  :file
        t.text    :filename, :content_type
        t.references :moduser, :class_name => "User", :foreign_key => 'moduser_id'
        t.timestamps
      end

      add_index :degrees, [:name], :name => :degrees_name_key, :unique => true
      add_index :careers, [:name, :degree_id, :school_id], :name => :careers_name_key, :unique => true
      add_index :schools, [:name, :institution_id], :name => :schools_name_key, :unique => true
    #end
  end

  def self.down
    drop_table :schoolings, :careers, :schools, :degrees
  end
end
