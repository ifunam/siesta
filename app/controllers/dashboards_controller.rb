class DashboardsController < ApplicationController

  def show
    @user = User.find(current_user.id)
	if @user.person.nil? or @user.address.nil?
		redirect_to edit_profile_path
	else
		redirect_to profile_path(@user)
	end
  end

end