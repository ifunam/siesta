class Academics::StudentRequestsController < Academics::ApplicationController 
  respond_to :html, :xml
  def index
    @academic = AcademicClient.find_by_login(current_academics_user.login)
    @user_requests = UserRequest.find_sent_request_to_user_id(@academic.user_id).all
    respond_with(@user_requests)
  end

  def update
    @user_request = UserRequest.find(params[:id])
    if @user_request.update_attributes(:requeststatus_id => params[:requeststatus_id])
      redirect_to academics_student_requests_path
    end
  end
end
