class CreateUserRequests < ActiveRecord::Migration

  def self.up
    transaction do
      create_table :roles do |t|
        t.string   :name, :administrative_key, :null => false
        t.references :moduser, :class_name => "User", :foreign_key => 'moduser_id'
        t.timestamps
      end

      create_table :periods do |t|
        t.string :name, :null  => false
        t.date   :startdate,  :enddate, :null => false
        t.boolean :is_active, :null => false, :default => false
        t.references :moduser, :class_name => "User", :foreign_key => 'moduser_id'
        t.timestamps
      end

      create_table :user_requests do |t|
        t.references  :user, :period, :null => false
        t.references :moduser, :class_name => "User", :foreign_key => 'moduser_id'
        t.timestamps
      end

      add_index :user_requests, [:user_id, :period_id], :name => :user_requests_user_id_key, :unique => true
      add_index :roles, [:name], :name => :academicprograms_name_key, :unique => true
      add_index :periods, [:name, :startdate, :enddate], :name => :periods_name_key, :unique => true
    end
  end

  def self.down
    drop_table :user_requests, :periods, :academiprograms
  end
end
