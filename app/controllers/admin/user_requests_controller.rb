class Admin::UserRequestsController < SessionsController
  layout 'admin'
  def index
    @collection = UserRequest.paginate(:conditions => {:period_id => Period.most_recent.id, :requeststatus_id => 3 }, :include => [:user => [:person]], 
                                       :order => 'people.lastname1 ASC, people.lastname2 ASC, people.firstname ASC ', 
                                       :page => params[:page] || 1, :per_page => 20)
    respond_to do |format|
      format.html { render :action => :index }
    end
  end
  
  def show
    @user_request = UserRequestRequirement.find(params[:id])
    @user_profile = UserProfile.find(params[:id])
    respond_to do |format|
      format.html { render :action => :show }
    end
  end
end
