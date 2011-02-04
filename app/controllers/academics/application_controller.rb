class Academics::ApplicationController < ActionController::Base
  protect_from_forgery :except => [:update]
  layout 'academic'
  before_filter :authenticate_academic!

  # The current_user method is required by CanCan gem
  alias_method :current_user, :current_academic
  authorize_resource  :class => false
end
