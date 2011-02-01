class Academics::ApplicationController < ActionController::Base
  protect_from_forgery :except => [:update]
  layout 'academic'
  before_filter :authenticate_academic!
end
