class UserRequestsController < ApplicationController
  respond_to :html, :except => [:remote_incharge_users, :remote_dates]
  respond_to :js, :only => [:remote_incharge_users, :remote_dates]

  def index
    @user_requests = UserRequest.find_all_by_user_id(current_user.id)
    respond_with(@user_requests)
  end

  def new
    respond_with(@user_request = UserRequest.new)
  end

  def create
    @user_request = UserRequest.new(params[:user_request].merge(:user_id => current_user.id))
    @user_request.save
    respond_with(@user_request, :status => :created, :location => user_requests_path)
  end

  def edit
    @user_request = UserRequest.find(params[:id])
    respond_with(@user_request)
  end

  def update
    @user_request = UserRequest.find(params[:id])
    @user_request.update_attributes(params[:user_request].merge(:user_id => current_user.id))
    respond_with(@user_request, :status => :updated, :location => user_requests_path)
  end

  def destroy
    @user_request = UserRequest.find(params[:id])
    @user_request.destroy
    respond_with(@user_request)
  end
  
  def remote_incharge_users
    @collection = AdscriptionClient.find(params[:id]).users
  end
  
  def form_dates  
  end
end