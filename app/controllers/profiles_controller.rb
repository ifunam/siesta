class ProfilesController < ApplicationController
  respond_to :html, :except => [:person_state_list]
  respond_to :js, :only => [:person_state_list]

  def new 
    respond_with(@user = User.find(current_user.id))
  end

  def create
    @user = User.find(current_user.id)
    @user.update_attributes(params[:user])
    respond_with(@user, :status => :created, :location => profile_path)
  end

  def edit
    respond_with(@user = User.find(current_user.id), :status => :ok )
  end

  def update
    @user = User.find(current_user.id)
    @user.update_attributes(params[:user])
    respond_with(@user, :status => :updated, :location => profile_path)
  end

  def show
    respond_with(@user = User.find(current_user.id), :status => :ok )
  end

  def person_state_list
  end
end
