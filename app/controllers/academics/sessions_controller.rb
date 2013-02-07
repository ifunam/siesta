class Academics::SessionsController < Devise::SessionsController
  layout 'academic'
  skip_before_filter :authenticate_user!, :only => [:create, :new, :session]

  def new
    unless current_user.nil?
      redirect_to academics_root_url
    else
      super
    end
  end

  def create
    resource = warden.authenticate!(auth_options)
    set_flash_message(:notice, :signed_in) if is_navigational_format?
    sign_in(resource_name, resource)
    respond_with resource, :location => after_sign_in_path_for(:academics_user)
  end

  def destroy
    reset_session
    redirect_to new_academics_user_session_path
  end
end
