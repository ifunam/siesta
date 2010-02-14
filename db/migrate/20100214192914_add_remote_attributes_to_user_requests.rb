class AddRemoteAttributesToUserRequests < ActiveRecord::Migration
  def self.up
    add_column :user_requests, :remote_adscription_id, :integer
    add_column :user_requests, :remote_user_incharge_id, :integer
  end

  def self.down
    remove_column :user_requests, :remote_adscription_id
    remove_column :user_requests, :remote_user_incharge_id
  end
end
