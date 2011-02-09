class Accounts::SessionsController < Devise::SessionsController
  skip_before_filter :authenticate_user!, :only => [:new, :create]
  # GET /resource/sign_in
  def new
    reset_session
    super
  end

  # POST /resource/sign_in
  def create
    resource = warden.authenticate!(:scope => resource_name, :recall => "new")
    set_flash_message :notice, :signed_in
    sign_in_and_redirect(:user, resource)
  end
end
