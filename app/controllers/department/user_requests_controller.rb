class Department::UserRequestsController < ApplicationController
  layout 'academic'

  def index
    user_id = session[:user_id] 
    period_id = Period.most_recent.id
    @collection =  UserRequest.search(user_id, period_id)
    respond_to do |format|
        format.html { render :action => 'index' }
    end
  end
  
 end