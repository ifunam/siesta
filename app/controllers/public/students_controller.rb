class Public::StudentsController < ActionController::Base
  layout 'public'    
  respond_to :html

  def index
    respond_with(@collection = UserRequest.find_by_academic_login(params[:login]))
  end  
end
