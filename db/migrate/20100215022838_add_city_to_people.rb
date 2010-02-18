class AddCityToPeople < ActiveRecord::Migration
  def self.up
    add_column :people, :city, :string
  end

  def self.down
    remote_column :people, :city, :string
  end
end
