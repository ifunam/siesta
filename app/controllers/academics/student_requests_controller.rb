class Academics::StudentRequestsController < Academics::ApplicationController 
  respond_to :html
  def index
    @academic = AcademicClient.find_by_login(current_academic.login)
    @user_requests = UserRequest.where("user_requests.remote_user_incharge_id = #{@academic.user_id} AND user_requests.requeststatus_id <= 3").includes(:period).order('periods.startdate DESC').all
    respond_with(@user_requests)
  end

  def update
    @user_request = UserRequest.find(params[:id])
    if @user_request.update_attributes(:requeststatus_id => params[:requeststatus_id])
      redirect_to academics_student_requests_path
    end
  end
end
