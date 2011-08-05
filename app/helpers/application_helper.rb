module ApplicationHelper
  def blueprint(div_class, options={}, &block)
    content_tag(:div, options.merge(:class => div_class), &block)
  end
  
  def is_user_request_authorizable?(user_request)
    user_request.period.name == Period.activated.name and user_request.requeststatus.id = 3 and user_request.is_official == false and user_request.user.email =~ /fisica.unam.mx/
  end
end
