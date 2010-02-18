class ApplicationController < ActionController::Base
  include AuthenticationSystem
  #protect_from_forgery
  before_filter :require_login

  private 
  # Authentication filter
  def require_login
    unless current_user
      store_location
      flash[:notice] = "You must be logged in to access this page"
      redirect_to new_session_url
      return false
    end
  end


  # Authorization filter
  # def set_user_authorization
  #  Authorization.current_user = User.find(1)
  # end
end
