class Managers::ApplicationController < ActionController::Base
  layout 'admin'
  protect_from_forgery
  before_filter :authenticate_managers_user!
  # The current_user method is required by CanCan gem
  alias_method :current_user, :current_managers_user
  authorize_resource :class => false
end
