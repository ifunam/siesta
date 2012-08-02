class Accounts::SessionsController < Devise::SessionsController
  # GET /resource/sign_in
  def new
    @user = User.new
    super
  end

  # POST /resource/sign_in
  def create
    resource = warden.authenticate!(:scope => resource_name)
    set_flash_message :notice, :signed_in
    sign_in_and_redirect(:user, resource)
  end
end
