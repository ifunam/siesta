class ApplicationController < ActionController::Base

  before_filter :authenticate_user!
  layout :layout_by_resource

  def layout_by_resource
    devise_controller? ? "devise" : "application"
  end
end

