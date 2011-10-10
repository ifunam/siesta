class Academics::EventsController < Academics::ResourcesController
  defaults :resource_class => Event, :collection_name => 'events', :instance_name => 'event'

  def index
    @events = Event.all_by_activated_period
              .find_all_by_office_cubicle_id(params[:office_cubicle_id])
    respond_to do |format|
           format.html # index.html.erb
           format.xml  { render :xml => @events }
           format.js  {
             render :json => @events.collect(&:event_days_as_json).flatten
           }
     end
   end

   def new
     @user_request = UserRequest.find(params[:student_request_id]) 
     super
   end
   
   def create
     build_resource.remote_user_incharge_id = current_academics_user.id
     super
   end
   
   def edit
     @user_request = resource.user_request
     super
   end

end
