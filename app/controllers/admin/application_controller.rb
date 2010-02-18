class Admin::ApplicationController < ActionController::Base
  
  before_filter :require_admin_login
  include AuthenticationSystem
  
  def require_admin_login
    if session[:admin].nil?
      store_location
      flash[:notice] = "You must be logged in to access this page"
      redirect_to new_academic_session_url
      return false
    end
  end
end