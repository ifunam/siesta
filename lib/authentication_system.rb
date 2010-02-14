module AuthenticationSystem
  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    @current_user ||= current_user_session.record unless current_user_session.nil?
  end

  def store_location
    session[:return_to] = request.request_uri
  end
end
