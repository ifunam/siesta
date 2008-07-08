# Methods added to this helper will be available to all templates in the application.
require 'labels'
require 'finder'
module ApplicationHelper
  include Labels

  def get_controller_name
    get_label(controller_name)
  end
  
  def controller_name
    @controller.controller_class_name.sub(/Controller$/, '').underscore
  end
 
  def radio_buttons(attribute ,options)
    s = ''
    options[:values].each do |v|
      s << label_for_boolean(attribute.to_s.downcase, v) + @template.radio_button(@object_name, attribute, v, :checked => false)
    end
    s
  end

  def stop_observer(dom_id)
    javascript_tag " $('#{dom_id.to_s}').stopObserving('click', String.blank);"
    #http://www.prototypejs.org/api/event/stopObserving  (Using String.blank instead nil o nothing)
  end

  def logged_user
    session[:user_id].nil? ? '<login>' : User.find(session[:user_id]).login
  end
end
