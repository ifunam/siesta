require Rails.root.to_s + '/lib/data_section_verifier'
class UserRequestsController < UserResourcesController
  before_filter :verify_data_sections!

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
  def verify_data_sections!
    @sections = DataSection::Verifier.find_by_user_id(current_user.id)
    if @sections.missed?
      render :action => :missed_sections, :status => 403, :layout => true
    end
  end
end
