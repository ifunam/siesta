class AddActivitiesToUserRequests < ActiveRecord::Migration
  def change
    add_column :user_requests, :activities, :string
  end
end
