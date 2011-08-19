class Academics::ApplicationController < ActionController::Base
  protect_from_forgery :except => [:update]
  layout 'academic'
  before_filter :authenticate_academics_user!
  alias :current_user :current_academics_user
  authorize_resource :class => false
end
