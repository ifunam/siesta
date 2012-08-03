class Accounts::SessionsController < Devise::SessionsController
  #skip_before_filter :authenticate_user!, :only => [:new, :create]
  #skip_before_filter :authenticate_account!, :only => [:new, :create]
  # GET /resource/sign_in
  def new
    @user = User.new
    super
  end

  # POST /resource/sign_in
  def create
    resource = warden.authenticate!(auth_options)
    set_flash_message(:notice, :signed_in) if is_navigational_format?
    sign_in(:user, resource)
    respond_with resource, :location => after_sign_in_path_for(:user)
  end
end
