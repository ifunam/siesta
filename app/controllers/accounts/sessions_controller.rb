class Accounts::SessionsController < Devise::SessionsController
  skip_before_filter :authenticate_user!, :only => [:new, :create]

  # POST /resource/sign_in
  def create
    resource = warden.authenticate!(:scope => :account, :recall => "new")
    set_flash_message :notice, :signed_in
    sign_in_and_redirect(:user, resource)
  end
end
