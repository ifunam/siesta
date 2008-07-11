class Academic::UserRequestsController < ApplicationController
  layout 'academic'

  def index
    user_id = params[:user_id] || session[:user_id] 
    period_id = params[:period_id] || Period.most_recent.id
    @collection =  UserRequest.search(user_id, period_id)
    respond_to do |format|
        format.html { render :action => 'index' }
    end
  end
  
  def authorize
    @user_request = UserRequest.find_by_id_and_user_incharge_id(params[:id], session[:user_id])
    respond_to do |format|
      if @user_request.authorize
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
        format.js { render :action => 'unauthorize.rjs' }
      else
        format.js { render :action => 'errors.rjs' }
      end
    end
  end
  
end