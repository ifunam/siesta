class AddBuildingIdAndCubicleAndDesktopAndScheduleIdAndDisabilityAndSpecialRequirementToUserRequest < ActiveRecord::Migration
  def change
    add_column :user_requests, :had_desktop_in_previous_period, :boolean
    add_column :user_requests, :building_id, :integer
    add_column :user_requests, :cubicle, :string
    add_column :user_requests, :desktop, :string
    add_column :user_requests, :schedule_id, :integer
    add_column :user_requests, :disability_id, :integer
    add_column :user_requests, :has_disability, :boolean
    add_column :user_requests, :special_requeriment, :string
  end
end
