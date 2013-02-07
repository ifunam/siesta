class Academics::SessionsController < Devise::SessionsController
  layout 'academic'
  skip_before_filter :authenticate_user!, :only => [:create, :sign_in, :new, :session]
  skip_before_filter :authenticate_academics_user!, :only => [:create, :sign_in, :new, :session]

  def new
    unless current_academics_user.nil?
      redirect_to academics_student_requests_path
    else
      super
    end
  end

  def create
    resource = warden.authenticate!(auth_options)
    set_flash_message(:notice, :signed_in) if is_navigational_format?
    sign_in(resource_name, resource)
    respond_with resource, :location => academics_student_requests_path
  end

  def destroy
    reset_session
    redirect_to new_academics_user_session_path
  end
end
