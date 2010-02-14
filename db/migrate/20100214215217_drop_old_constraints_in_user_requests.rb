class DropOldConstraintsInUserRequests < ActiveRecord::Migration
  def self.up
    execute "ALTER TABLE user_requests ALTER COLUMN user_incharge_id DROP NOT NULL"
  end

  def self.down
    execute "ALTER TABLE user_requests ALTER COLUMN user_incharge_id SET NOT NULL"
  end
end
