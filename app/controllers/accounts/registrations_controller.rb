class Accounts::RegistrationsController < Devise::RegistrationsController
  skip_before_filter :authenticate_user!, :only => [:new, :create]

  def create
    build_resource
    if resource.save
      set_flash_message :notice, :signed_up
      sign_in_and_redirect(:user, resource)
    else
      clean_up_passwords(resource)
      render_with_scope :new
    end
  end

end
