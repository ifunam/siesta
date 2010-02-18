class UserRequestsController < ApplicationController
  respond_to :html
  respond_to :js, :only => [:remote_incharge_users, :remote_dates]

  def index
    @user_requests = UserRequest.find_all_by_user_id(current_user.id)
    respond_with(@user_requests)
  end

  def new
    @user_request = UserRequest.new
    respond_with(@user_request)
  end

  def create
    @user_request = UserRequest.new(params[:user_request])
    @user_request.user_id = current_user.id
    flash[:notice] = "Your user_request has been saved" if @user_request.save
    respond_with(@user_request) do |format|
      format.html { redirect_to user_requests_path}
    end
  end

  def edit
    @user_request = UserRequest.find(params[:id])
    respond_with(@user_request)
  end

  def update
    @user_request = UserRequest.find(params[:id])
    @user_request.user_id = current_user.id
    flash[:notice] = "Your user_request has been saved" if @user_request.update_attributes(params[:user_request])
    respond_with(@user_request) do |format|
      format.html { redirect_to user_requests_path}
    end
  end

  def destroy
    @user_request = UserRequest.find(params[:id])
    flash[:notice] = "Your user_request has been deleted" if @user_request.destroy
    respond_with(@user_request)
  end
  
  def remote_incharge_users
    @collection = AdscriptionClient.find(params[:id]).users
  end
  
  def form_dates  
  end
  
end