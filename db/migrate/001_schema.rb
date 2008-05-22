class Schema < ActiveRecord::Migration
  def self.up
    #transaction do
      create_table :userstatuses, :force => true do |t|
        t.text     :name, :null => false
        t.timestamps
      end

      create_table :users, :force => true do |t|
        t.text       :login, :null => false
        t.text       :passwd, :salt, :email,  :homepage, :blog, :calendar, :pkcs7, :token
        t.references :userstatus,  :default => 1, :null => false
        t.datetime   :token_expiry
        t.references :user_incharge, :class_name => "User", :foreign_key => 'user_incharge_id'
        t.references :moduser, :class_name => "User", :foreign_key => 'moduser_id'
        t.timestamps
      end

      create_table :countries, :force => true do |t|
        t.text   :name, :citizen, :null => false
        t.string :code,    :limit => 3, :null => false
      end

      create_table :states, :force => true do |t|
        t.references  :country, :null => false
        t.text     :name,       :null => false
        t.text     :code
        t.references :moduser, :class_name => "User", :foreign_key => 'moduser_id'
        t.timestamps
      end

      create_table :cities, :force => true do |t|
        t.references :state,   :null => false
        t.text        :name,       :null => false
        t.references :moduser, :class_name => "User", :foreign_key => 'moduser_id'
        t.timestamps
      end

      create_table :people, :force => true do |t|
        t.references  :user, :country, :state, :city, :null => false
        t.text     :firstname,  :lastname1,  :null => false
        t.text     :lastname2, :photo_filename, :photo_content_type, :other
        t.boolean  :gender, :null => false
        t.date     :birthdate,        :null => false
        t.binary   :photo
        t.references :moduser, :class_name => "User", :foreign_key => 'moduser_id'
        t.timestamps
      end

      create_table :trees, :force => true do |t|
        t.references  :parent, :class_name => "Tree", :foreign_key => "parent_id"
        t.integer  :pos
        t.integer  :lft
        t.integer  :rgt
        t.references  :root, :class_name => "Tree", :foreign_key => "root_id"
        t.string   :data
        t.references :moduser, :class_name => "User", :foreign_key => 'moduser_id'
        t.timestamps
      end

      add_index :users, [:id], :name => "users_id_idx"
      add_index :users, [:login], :name => "users_login_idx"
      add_index :users, [:email], :name => "users_email_key", :unique => true
      add_index :userstatuses, [:name], :name => "userstatuses_name_key", :unique => true
      add_index :countries, [:code], :name => "countries_code_key", :unique => true
      add_index :countries, [:name], :name => "countries_name_key", :unique => true
      add_index :states, [:name, :country_id], :name => "states_name_key", :unique => true
      add_index :cities, [:state_id, :name], :name => "cities_state_id_key", :unique => true
    #end
    change_column :countries, :id, :integer, :null => false
  end

  def self.down
    drop_table :users, :userstatuses
    drop_table :cities, :states, :countries
    drop_table :people
    drop_table :trees
  end
end
