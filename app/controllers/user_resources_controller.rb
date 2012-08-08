class UserResourcesController < InheritedResources::Base
  respond_to :html
  before_filter :authorize_action!, :except => [:index, :new, :create]

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

  def authorize_action!
    unless current_user.current_sign_in_ip == request.remote_ip and resource.user_id == current_user.id
      authorize! :unauthorized, resource.class.name, :message => 'Unauthorized action!'
    end
  end
end
