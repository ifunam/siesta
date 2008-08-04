class SendUserRequestsController < ApplicationController
  def index
    @user_request = UserRequestRequirement.find(session[:user_id])
    respond_to do |format|
      format.js { render :action => 'index.rjs' }
      format.html { render :action => 'index'}
    end
  end

  def send_request
    @urequest = UserRequest.find_by_id_and_user_id(params[:id], session[:user_id])
    respond_to do |format|
      if @urequest.send_request
        @user = User.find(session[:user_id])
        UserNotifier.deliver_user_request(@user)
        UserNotifier.deliver_academic_request(@user, @user.user_incharge)
        flash[:notice] = 'Su solicitud de ingreso se ha enviado!'
        format.html { redirect_to :action => 'index'}
      else
        format.html { redirect_to :action => 'index'}
      end
    end
  end
end
