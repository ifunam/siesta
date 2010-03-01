class RecoverPasswordsController < ApplicationController
  skip_before_filter :require_login, :only => [:new, :create] 
  respond_to :html
  layout 'session'

  def new
    respond_with(@user = User.new)
  end

  def create
    @user = User.find_by_email(params[:user][:email])
    unless @user.nil?
      @user.randomize_password
      respond_with(@user)
    else 
      redirect_to new_recover_password_path
    end
  end
end
