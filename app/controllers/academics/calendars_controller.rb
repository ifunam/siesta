class Academics::CalendarsController < Academics::ResourcesController
  defaults :resource_class => OfficeCubicle, :collection_name => 'office_cubicles', :instance_name => 'office_cubicle'

  def index
    @period = Period.activated
    super
  end

  def show
    @period = Period.find(params[:period_id])
    super
  end
end