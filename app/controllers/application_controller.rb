class ApplicationController < ActionController::Base
  protect_from_forgery
  if controller_path.to_s.match(/^academic|managers|librarians/).nil?
    before_filter :authenticate_user!
  end

  layout :layout_by_resource

  rescue_from CanCan::AccessDenied do |exception|
    render :action=> :unauthorized, :status => 403, :layout => true
  end

  def layout_by_resource
    devise_controller? ? "devise" : "application"
  end

end
