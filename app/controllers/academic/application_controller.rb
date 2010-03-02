class Academic::ApplicationController < ActionController::Base
  before_filter :require_academic_login
  include AuthenticationSystem
  
  def require_academic_login
    if session[:academic].is_a? Hash and session[:academic].empty?
      store_location
      flash[:notice] = "You must be logged in to access this page"
      redirect_to new_academic_session_url
      return false
    end
  end
end
