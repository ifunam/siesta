class Users::SessionsController < Devise::SessionsController
  # GET /resource/sign_in
  
  def new
    @account = Account.new
    super
  end

  def create
    if Period.activated.expired?
      flash[:error] = t(:expired_period)
      redirect_to new_user_session_path
    else
      super
    end
  end
end
