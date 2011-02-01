class Managers::ApplicationController < ActionController::Base
  protect_from_forgery
  layout 'admin'
  before_filter :authenticate_manager!
end
