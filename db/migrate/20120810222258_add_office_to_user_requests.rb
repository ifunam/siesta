class AddOfficeToUserRequests < ActiveRecord::Migration
  def change
    add_column :user_requests, :office, :string
  end
end
