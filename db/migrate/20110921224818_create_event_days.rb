class CreateEventDays < ActiveRecord::Migration
  def self.up
    create_table :event_days do |t|
      t.integer :day
      t.references :event
      t.datetime :start_at
      t.datetime :end_at

      t.timestamps
    end
  end

  def self.down
    drop_table :event_days
  end
end
