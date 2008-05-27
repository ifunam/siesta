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
  def text_field_for_date(attribute, options)
    text_field_date(attribute, 2, 3) + ' / ' +  text_field_date(attribute, 2, 2) + ' / '  + text_field_date(attribute, 4, 1)
  end

  def text_field_date(attribute, size, order)
    k = [:year, :month, :day]
    v =  nil
    if !@object.nil? and !@object.send(attribute).nil?
      v = @object.send(attribute).send(k[(order -1)])
      v = "0#{v}" if v.to_s.size < 2
    end
    @template.text_field_tag("#{@object_name}[#{attribute}(#{order}i)]", v,
                             :size => size, :maxlength => size, :id => "#{@object_name}_#{attribute}_#{order}i")
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
    session[:user].nil? ? '<login>' : User.find(session[:user]).login
  end
end
