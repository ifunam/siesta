class Managers::SessionsController < Devise::SessionsController
  skip_before_filter :authenticate_user!, :only => [:create, :new]
  def create
    resource = warden.authenticate!(:scope => resource_name)
    sign_in(resource_name, resource)
    if managers_user_signed_in?
      redirect_to managers_students_path
    else
      redirect_to new_managers_user_session_path
    end    
  end
end