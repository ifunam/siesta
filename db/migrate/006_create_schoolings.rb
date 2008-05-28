class CreateSchoolings < ActiveRecord::Migration
  def self.up
    #transaction do
      create_table :degrees do |t|
        t.text     :name, :null => false
        t.references :moduser, :class_name => "User", :foreign_key => 'moduser_id'
        t.timestamps
      end

      # create_table :careers do |t|
      #   t.text     :name, :null => false
      #   t.references  :degree, :institution, :null => false
      #   t.references :moduser, :class_name => "User", :foreign_key => 'moduser_id'
      #   t.timestamps
      # end

      create_table :schoolings do |t|
        t.references :user, :degree, :country,:null => false
        t.text  :career, :school, :institution, :null => false # TODO: Use career reference instead these fields
        t.integer :startmonth, :startyear, :null => false
        t.integer :endmonth, :endyear, :credits  #, :estimated_endmonth, :estimated_endyear
        t.string  :studentid                                     # TODO: Check for estimated month and year at schoolings table
        t.float   :average
        t.boolean :is_studying_this, :default => true, :null => false
        t.boolean :is_titleholder, :default => false, :null => false
        t.binary  :file, :null => false
        t.text    :filename, :content_type, :null => false

        t.references :moduser, :class_name => "User", :foreign_key => 'moduser_id'
        t.timestamps
      end

      add_index :degrees, [:name], :name => :degrees_name_key, :unique => true
      #add_index :careers, [:name, :degree_id, :institution_id], :name => :careers_name_key, :unique => true
    #end
  end

  def self.down
    drop_table :schoolings, :careers, :degrees
  end
end
