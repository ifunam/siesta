class DashboardsController < ApplicationController

  def show
    @user = User.find(current_user.id)
    redirect_to edit_profile_path(:id =>current_user.id)
  end

end
