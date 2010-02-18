module ApplicationHelper
  include AuthenticationSystem
  def blueprint(div_class, options={}, &block)
    content_tag(:div, options.merge(:class => div_class), &block)
  end
end
