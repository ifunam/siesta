class ApplicationController < ActionController::Base

  protect_from_forgery :except => [:destroy, :update]
  before_filter :authenticate_user!
end

