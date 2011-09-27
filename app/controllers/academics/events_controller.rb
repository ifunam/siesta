class Academics::EventsController < Academics::ResourcesController
   defaults :resource_class => Event, :collection_name => 'events', :instance_name => 'event'
   
   def new
     @user_request = UserRequest.find(params[:student_request_id]) 
     super
   end
   
end
