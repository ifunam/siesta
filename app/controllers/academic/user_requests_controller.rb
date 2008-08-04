class Academic::UserRequestsController < ApplicationController
  layout 'academic'

  def index
    user_incharge_id = params[:user_id] || session[:user_id] 
    period_id = params[:period_id] || Period.most_recent.id
    @collection =  UserRequest.search(:user_incharge_id => user_incharge_id, :period_id => period_id)
    respond_to do |format|
        format.html { render :action => 'index' }
    end
  end
  
  def authorize
    @user_request = UserRequest.find_by_id_and_user_incharge_id(params[:id], session[:user_id])
    respond_to do |format|
      if @user_request.authorize
        UserNotifier.deliver_user_request_authorized(@user_request.user_incharge, @user_request.user_id)
        format.js { render :action => 'authorize.rjs' }
      else
        format.js { render :action => 'errors.rjs' }
      end
    end
  end
  
  def unauthorize
    @user_request = UserRequest.find_by_id_and_user_incharge_id(params[:id], session[:user_id])
    respond_to do |format|
      if @user_request.unauthorize
        UserNotifier.deliver_user_request_unauthorized(@user_request.user_incharge, @user_request.user_id)
        format.js { render :action => 'unauthorize.rjs' }
      else
        format.js { render :action => 'errors.rjs' }
      end
    end
  end
  
end