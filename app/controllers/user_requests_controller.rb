class UserRequestsController < SharedController
 def initialize
   @model = UserRequest
   super
   @columns = %w(period is_restamped role)
 end
end