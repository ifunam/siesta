class SendUserRequestsController < ApplicationController
  def show
    @user_request = UserRequestRequirement.find(current_user.id)
  end
  
  def update
    @user_request = UserRequest.find(params[:id])
    @user_request.send_request
    redirect_to send_user_request_path
  end
end