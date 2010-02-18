class ProfilesController < ApplicationController
  respond_to :html
  respond_to :js, :only => [:person_state_list]
  
  def new 
    @user = User.find(current_user.id)
    respond_with(@user)
  end

  def edit
    @user = User.find(current_user.id)
    respond_with(@user)
  end

  def update
    @user = User.find(current_user.id)
    flash[:notice] = 'Your data has been saved' if @user.update_attributes(params[:user])
    respond_with(@user) do |format|
      format.html { redirect_to profile_path }
    end
  end

  def create
    @user = User.find(current_user.id)
    flash[:notice] = 'Your data has been saved' if @user.update_attributes(params[:user])
    respond_with(@user) do |format|
      format.html { redirect_to profile_path}
    end
  end

  def show
    @user = User.find(current_user.id)
    respond_with(@user)
  end
  
  def person_state_list
  end
end
