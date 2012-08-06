class ProfilesController < ApplicationController
  respond_to :html, :except => [:state_list]
  respond_to :js, :only => [:state_list]

  def show
    @user = User.find(current_user.id)
    unless @user.person_or_address?
      respond_with(@user)
    else
      redirect_to edit_profile_path(@user)
    end
  end

  def edit
    respond_with(@user = User.find_profile(current_user.id), :status => :ok )
  end

  def update
    @user = User.find(current_user.id)
    @user.update_attributes(params[:user])
    respond_with(@user, :status => :updated, :location => profile_path)
  end

  def state_list
    render :action => 'person_state_list', :layout => false
  end
end
