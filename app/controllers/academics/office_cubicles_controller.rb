class Academics::OfficeCubiclesController < InheritedResources::Base
   skip_before_filter :authenticate_user!
   layout 'academic'
   defaults :resource_class => OfficeCubicle, :collection_name => 'office_cubicles', :instance_name => 'office_cubicle'
   
   def index
     set_collection_ivar resource_class.paginate(:page => params[:page] ||1, :per_page => params[:per_page] || 10)
     super
   end
end
