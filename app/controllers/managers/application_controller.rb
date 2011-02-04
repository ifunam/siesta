class Managers::ApplicationController < ActionController::Base
  protect_from_forgery
  layout 'admin'
  before_filter :authenticate_manager!
  alias_method :current_user, :current_manager

  authorize_resource :class => false
end
