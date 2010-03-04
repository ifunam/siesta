class SendUserRequestsController < ApplicationController
  respond_to :html
  
  def show
    @user_request = UserRequestRequirement.find(current_user.id)
    respond_with(@user_request)
  end
  
  def update
    @user_request = UserRequest.find(params[:id])
    @user_request.send_request
    respond_with(@user_request, :status => :updated, :location => send_user_request_path)
  end
end