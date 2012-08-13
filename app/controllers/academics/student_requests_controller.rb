class Academics::StudentRequestsController < Academics::ApplicationController 
  respond_to :html, :xml
  def index
    @academic = AcademicClient.find_by_login(current_academics_user.login)
    @user_requests = UserRequest.find_sent_request_to_user_id(@academic.id).all
    respond_with(@user_requests)
  end

  def approve
    UserRequest.find(params[:id]).approve
    redirect_to academics_student_requests_path
  end

  def reject
    UserRequest.find(params[:id]).reject
    redirect_to academics_student_requests_path
  end
end
