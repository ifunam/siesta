class UpdateAddressCity < ActiveRecord::Migration
  def self.up
    Address.all.each do |record|
      unless record.city_id.nil?
        record.city = City.find(record.city_id).name
        record.save
      end
    end
  end

  def self.down
    Address.all.each do |record|
      unless record.city_id.nil?
        record.city = nil
        record.save
      end
    end
  end
end
