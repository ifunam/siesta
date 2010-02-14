class AddDatesToUserRequests < ActiveRecord::Migration
  def self.up
    add_column :user_requests, :start_month, :integer
    add_column :user_requests, :start_year, :integer
    add_column :user_requests, :end_month, :integer
    add_column :user_requests, :end_year, :integer
  end

  def self.down
    [:start_month, :start_year, :end_month, :end_year].each do |column_name|
      remove_column :user_requets, column_name
    end
  end
end
