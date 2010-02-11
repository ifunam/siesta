class SessionsController < ApplicationController

  skip_before_filter :require_login, :only => [:new, :create] 

  #include SslRequirement
  # ssl_required :create, :new, :recover_password if Rails.env == "production"
  caches_action :new

  def new
    @session = UserSession.new
  end
  
  def create
    @session = UserSession.new(params[:user_session])
    if @session.save
      flash[:notice] = "Login successful!"
      redirect_to :controller => dashboard_path,  :protocol => 'http'
    else
      render 'new'
    end
  end
  
  def destroy
    current_user_session.destroy
    flash[:notice] = "Logout successful!"
    redirect_back_or_default new_session_url
  end
end
