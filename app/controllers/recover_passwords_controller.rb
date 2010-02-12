class RecoverPasswordsController < ApplicationController
  skip_before_filter :require_login, :only => [:new, :create] 
  caches_action :new

  respond_to :js

  def new
    @user = User.new
    respond_with(@user)
  end
  
  def create
    @user = User.find_by_email(params[:login][:email])
    flash[:notice] = "Password was sent successfully." if @user.ramdomize_password
    respond_with(@user)
  end
end
