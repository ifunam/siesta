class Academics::StudentRequestsController < Academics::ApplicationController 
  def index
    # @user_requests = UserRequest.where(:remote_user_incharge_id => session[:academic][:id].to_i).includes(:period).order('periods.startdate DESC').all
      @academic = AcademicClient.find_by_login(current_academic.login)
      @user_requests = UserRequest.where("user_requests.remote_user_incharge_id = #{@academic.user_id} AND user_requests.requeststatus_id <= 3").includes(:period).order('periods.startdate DESC').all
    render 'index'
  end

  def update
    @user_request = UserRequest.find(params[:id])
    if @user_request.update_attributes(:requeststatus_id => params[:requeststatus_id])
      redirect_to academics_student_requests_path
    end
  end
end
