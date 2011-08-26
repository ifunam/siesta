class CreateOfficeCubicles < ActiveRecord::Migration
  def self.up
    create_table :office_cubicles do |t|
      t.references :cubicle_type
      t.references :building
      t.string :name_or_number
      t.integer :number_of_desktops
      t.integer :number_of_computers

      t.timestamps
    end
  end

  def self.down
    drop_table :office_cubicles
  end
end
