class RecoverPasswordsController < ApplicationController
  skip_before_filter :require_login, :only => [:new, :create] 
  caches_action :new
  respond_to :html
  layout 'session'

  def new
    @user = User.new
    respond_with(@user)
  end

  def create
    @user = User.find_by_email(params[:user][:email])
    flash[:notice] = "Password was sent successfully." 
    if !@user.nil? and @user.randomize_password
      current_user_session.destroy unless current_user_session.nil?            
      render 'show'
    else
      redirect_to new_recover_password_path
    end
  end
end
