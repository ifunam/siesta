class CreateDisabilities < ActiveRecord::Migration
  def change
    create_table :disabilities do |t|
      t.string :name
      t.references :disability_type

      t.timestamps
    end
    add_index :disabilities, :disability_type_id
  end
end
