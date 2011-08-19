class Academics::SessionsController < Devise::SessionsController
  skip_before_filter :authenticate_user!, :only => [:create, :new]
  def create
    resource = warden.authenticate!(:scope => resource_name)
    #set_flash_message(:notice, :signed_in) if is_navigational_format?
    sign_in(resource_name, resource)
    if academics_user_signed_in?
      redirect_to academics_student_requests_path
    else
      redirect_to new_academics_user_session_path
    end    
  end
end