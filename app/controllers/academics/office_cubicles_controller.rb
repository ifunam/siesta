class Academics::OfficeCubiclesController < Academics::ResourcesController
   defaults :resource_class => OfficeCubicle, :collection_name => 'office_cubicles', :instance_name => 'office_cubicle'
end
