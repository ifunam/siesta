class AddCityToAddresses < ActiveRecord::Migration
  def self.up
    add_column :addresses, :city, :string
  end

  def self.down
    remote_column :addresses, :city, :string
  end
end
