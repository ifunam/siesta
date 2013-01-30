class CreateDisabilityTypes < ActiveRecord::Migration
  def change
    create_table :disability_types do |t|
      t.string :name

      t.timestamps
    end
  end
end
