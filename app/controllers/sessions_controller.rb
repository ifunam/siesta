class SessionsController < ApplicationController
  include SslRequirement
  ssl_required :create, :new, :recover_password if Rails.env == "production"
  skip_before_filter :require_login, :only => [:new, :create] 

  caches_action :new
  layout 'session'
  respond_to :html

  def new
    @session = UserSession.new
    respond_with(@session)
  end

  def create
    @session = UserSession.new(params[:user_session])
    flash[:notice] = "User was created successfully." if @session.save
    respond_with(@session) do |format|
      format.html { redirect_to dashboard_path, :protocol => 'http' }
    end
  end

  def destroy
    current_user_session.destroy
    flash[:notice] = "Logout successful!"
    redirect_to new_session_url
  end
end
