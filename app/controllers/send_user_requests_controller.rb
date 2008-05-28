class SendUserRequestsController < ApplicationController
  def index
    @user_request = UserRequestRequirement.find(session[:user])
    respond_to do |format|
      if request.xhr?
        format.html { render :action => 'index', :layout => false}
      else
        format.html { render :action => 'index'}
      end
    end
  end

  def send_request
    @request = UserRequest.find(:first, :conditions => ['id = ? AND user_id = ?', params[:id], session[:user]])
    @user = User.find(session[:user])
    respond_to do |format|
      if @request.send_request
        UserNotifier.deliver_applicant_request(@user)
        flash[:notice] = 'Su solicitud de ingreso se ha enviado!'
        format.html { redirect_to :action => 'index'}
      else
        format.html { redirect_to :action => 'index'}
      end
    end
  end
end
