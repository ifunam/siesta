class ProfilesController < ApplicationController
  respond_to :html
  def show
    @user = User.find(current_user.id)
    if @user.person_or_address?
      respond_with(@user)
    else
      redirect_to edit_profile_path
    end
  end

  def edit
    respond_with(@user = User.find_profile(current_user.id), :status => :ok )
  end

  def update
    @user = User.find(current_user.id)
    @user.update_attributes(params[:user])
    respond_with(@user, :status => :updated, :location => profile_path, :notice => t(:profile_saved))
  end
end
