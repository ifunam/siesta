class UserResourcesController < InheritedResources::Base
  respond_to :html

  def index
    respond_with set_collection_ivar(resource_class.find_all_by_user_id(current_user.id))
  end

  def create
    build_resource.user_id = current_user.id
    super
  end

  def update
    resource.user_id = current_user.id
    super
  end

  def destroy
    if resource.user_id == current_user.id
      super
    end
  end  
end
