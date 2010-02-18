class Academic::StudentRequestsController < Academic::ApplicationController 
  layout 'academic'
  def index
    @user_requests = UserRequest.where(:remote_user_incharge_id => session[:academic][:id].to_i).includes(:period).order('periods.startdate DESC').all
    render 'index'
  end
  
  def update
    @user_request = UserRequest.find(params[:id])
    if @user_request.update_attributes(:requeststatus_id => params[:requeststatus_id])
      redirect_to academic_student_requests_path
    end
  end
end