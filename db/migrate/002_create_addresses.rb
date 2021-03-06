class CreateAddresses < ActiveRecord::Migration
  def self.up
    #transaction do
      create_table :addresstypes, :force => true do |t|
        t.text            :name, :null => false
        t.references :moduser, :class_name => "User", :foreign_key => 'moduser_id'
        t.timestamps
      end

      create_table :addresses, :force => true do |t|
        t.references   :user, :addresstype, :country, :city, :null => false
        t.references   :state
        t.text         :location, :null => false
        t.integer      :zipcode
        t.text         :pobox, :phone, :fax, :movil, :other
        t.boolean      :is_postaddress, :default => false, :null => false
        t.references :moduser, :class_name => "User", :foreign_key => 'moduser_id'
        t.timestamps
      end

      add_index :addresses, [:user_id, :addresstype_id], :name => :addresses_user_id_key, :unique => true
      add_index :addresstypes, [:name], :name => :addresstypes_name_key, :unique => true
    #end
  end
  
  def self.down
    drop_table :addresses, :addresstypes
  end
end
