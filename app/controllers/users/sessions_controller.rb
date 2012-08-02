class Users::SessionsController < Devise::SessionsController
  # GET /resource/sign_in
  
  def new
    @account = Account.new
    super
  end
end
