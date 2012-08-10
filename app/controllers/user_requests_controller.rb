class UserRequestsController < UserResourcesController
  before_filter :verify_requirements!

  def index
    set_collection_ivar resource_class.find_all_by_user_id(current_user.id)
    if collection.size > 0
      super
    else
      redirect_to new_user_request_path
    end
  end

  def create
    build_resource.user_id = current_user.id
    resource.period_id = Period.activated.id
    create! do
      resource.send_request
    end
  end

  private
  def verify_requirements!
    @requirements = UserRequestRequirement.find(current_user.id)
    unless @requirements.has_filled_requirements?
      render :action => :missed_sections, :status => 406, :layout => true
     #authorize! :missed_sections, UserRequest, :message => 'Missed requirements!' 
    end
  end
end
