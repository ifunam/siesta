class UserRequestsController < UserResourcesController
  respond_to :html, :except => [:remote_incharge_users, :remote_dates]
  respond_to :js, :only => [:remote_incharge_users, :remote_dates]

  def remote_incharge_users
    @collection = AdscriptionClient.find(params[:id]).users
  end

  def form_dates
  end
end
