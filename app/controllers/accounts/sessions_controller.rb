class Accounts::SessionsController <  ApplicationController
  skip_before_filter :authenticate_user!, :only => [:new, :create]
  include Devise::Controllers::InternalHelpers

  # GET /resource/sign_in
  def new
    clean_up_passwords(build_resource)
    render_with_scope :new
  end

  # POST /resource/sign_in
  def create
    resource = warden.authenticate!(:scope => :account, :recall => "new")
    set_flash_message :notice, :signed_in
    sign_in_and_redirect(:user, resource)
  end

  # GET /resource/sign_out
  def destroy
    set_flash_message :notice, :signed_out if signed_in?(resource_name)
    sign_out_and_redirect(resource_name)
  end
end
