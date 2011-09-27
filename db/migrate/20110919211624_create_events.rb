class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.references :user_request, :office_cubicle
      t.integer :remote_user_incharge_id
      t.datetime :start_at
      t.datetime :end_at
      t.boolean :all_day
      t.timestamps
    end
  end

  def self.down
    drop_table :events
  end
end
