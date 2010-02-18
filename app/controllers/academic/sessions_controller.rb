class Academic::SessionsController < Academic::ApplicationController 
  skip_before_filter :require_academic_login, :only => [:new, :create] 
  
  layout 'session'
  def new
    @session = User.new
  end

  def create
    if SessionClient.authenticate?(params[:user][:login],params[:user][:password])
      @academic = AcademicClient.find_by_login(params[:user][:login])
      session[:academic] = { :id => @academic.user_id, :login => @academic.login, :email => @academic.email }
      redirect_to academic_student_requests_path
    else
      redirect_to new_academic_session_path
    end
  end
  
  def destroy
    reset_session
    redirect_to new_academic_session_path
  end
end