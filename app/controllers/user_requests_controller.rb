class UserRequestsController < UserResourcesController
  respond_to :html, :except => [:remote_incharge_users, :remote_dates]
  respond_to :js, :only => [:remote_dates]
  
  def remote_incharge_users
    respond_with(@collection = AdscriptionClient.find(params[:id]).users) do |format|
      format.html { render :action => 'remote_incharge_users', :layout => false}
    end
  end

  def form_dates
    render :action => 'form_dates', :layout => false
  end
end
