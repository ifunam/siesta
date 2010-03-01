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
    respond_with(@session = UserSession.create(params[:user_session]), :status => :created, :location =>  dashboard_path)
  end

  def destroy
    current_user_session.destroy
    redirect_to new_session_url
  end
end
