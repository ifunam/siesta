class Managers::SessionsController < Devise::SessionsController
  skip_before_filter :authenticate_user!, :only => [:create, :new]
  def create
    resource = warden.authenticate!(auth_options)
    set_flash_message(:notice, :signed_in) if is_navigational_format?
    sign_in(resource_name, resource)
    respond_with resource, :location => after_sign_in_path_for(:managers_user)
  end
end
