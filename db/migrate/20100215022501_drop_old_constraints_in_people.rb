class DropOldConstraintsInPeople < ActiveRecord::Migration
  def self.up
    execute "ALTER TABLE people ALTER COLUMN city_id DROP NOT NULL"
  end

  def self.down
    execute "ALTER TABLE people ALTER COLUMN city_id SET NOT NULL"
  end
end
