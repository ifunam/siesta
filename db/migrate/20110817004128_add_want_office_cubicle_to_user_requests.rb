class AddWantOfficeCubicleToUserRequests < ActiveRecord::Migration
  def self.up
    add_column :user_requests, :want_office_cubicle, :bool
  end

  def self.down
    remove_column :user_requests, :want_office_cubicle
  end
end
