class SessionsController < ApplicationController
  # include SslRequirement
  # ssl_required :create, :new, :recover_password if Rails.env == "production"
  skip_before_filter :require_login, :only => [:new, :create] 

  caches_action :new
  layout 'session'
  respond_to :html

  def new
    @session = UserSession.new
    respond_with(@session)
  end

  def create
    @user = User.first(:conditions => {:login => params[:user_session][:login]})
    if !@user.nil? and @user.perishable_token.nil? and @user.persistence_token.nil?
      if User.myauthenticate?(params[:user_session][:login], params[:user_session][:password])
        @user.password = params[:user_session][:password]
        @user.password_confirmation = params[:user_session][:password]
        @user.save
      end
    end
    @session = UserSession.new(params[:user_session])
    flash[:notice] = 'Login successful!' if @session.save
    respond_with(@session) do |format|
      format.html { redirect_to dashboard_path, :protocol => 'http'}
    end
  end

  def destroy
    current_user_session.destroy
    flash[:notice] = "Logout successful!"
    redirect_to new_session_url
  end
end
