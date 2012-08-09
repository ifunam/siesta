class UserRequestsController < UserResourcesController
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
    resource.period_id = Period.most_recent.id
    create! do
      resource.send_request
    end
  end
end
