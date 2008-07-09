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
  
  def update

  end
end