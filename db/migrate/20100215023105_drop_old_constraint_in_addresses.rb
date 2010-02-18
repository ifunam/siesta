class DropOldConstraintInAddresses < ActiveRecord::Migration
  def self.up
    execute "ALTER TABLE addresses ALTER COLUMN city_id DROP NOT NULL"
  end

  def self.down
    execute "ALTER TABLE addresses ALTER COLUMN city_id SET NOT NULL"
  end
end
