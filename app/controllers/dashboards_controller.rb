class DashboardsController < ApplicationController

  def show
    @user = User.find(current_user.id)
    if @user.person.nil? and @user.address.nil?
      redirect_to new_profile_path
    else
      redirect_to edit_profile_path
    end
  end

end