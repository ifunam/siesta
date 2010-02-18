require 'net/ssh'
class Admin::SessionsController < Admin::ApplicationController 
  skip_before_filter :require_admin_login, :only => [:new, :create] 

  layout 'session'
  def new
    @session = User.new
  end

  def create
    if ssh_authenticate?(params[:user][:login],params[:user][:password])
      session[:admin] = User.find_by_login(params[:user][:login])
      redirect_to admin_students_path
    else
      redirect_to new_admin_session_path
    end
  end
  
  def destroy
    reset_session
    redirect_to new_admin_session_path
  end
  
  def ssh_authenticate?(login, password)
    begin
      return true if Net::SSH.start("fenix.fisica.unam.mx", login, :password => password) 
    rescue StandardError => bang
      return false
    end
  end  
end