class SessionsController < ApplicationController
  include SslRequirement
  ssl_required :create, :new, :recover_password if Rails.env == "production"
  skip_before_filter :require_login, :only => [:new, :create] 

  layout 'session'
  respond_to :html

  def new
    respond_with(@session = UserSession.new)
  end

  def create
    respond_with(@session = UserSession.create(params[:user_session])) do |format|
      format.html { redirect_to dashboard_path, :protocol => 'http'}
    end
  end

  def destroy
    respond_with(current_user_session.destroy) do |format|
      format.html { redirect_to new_session_url }
    end
  end
end
