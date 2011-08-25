class CreateOfficeCubicles < ActiveRecord::Migration
  def self.up
    create_table :office_cubicles do |t|
      t.string :name_or_number
      t.references :building
      t.references :room_type
      t.references :number_of_desktops
      t.references :number_of_computers
      t.timestamps
    end
  end

  def self.down
    drop_table :rooms
  end
end
