# encoding: utf-8
module ApplicationHelper
  def blueprint(div_class, options={}, &block)
    content_tag(:div, options.merge(:class => div_class), &block)
  end

  def is_user_request_authorizable?(user_request)
    user_request.period.name == Period.activated.name and user_request.requeststatus.id = 3 and user_request.is_official == false and user_request.user.email =~ /fisica.unam.mx/
  end

  def link_to_office_cubicle(student_request)
    if student_request.events.size == 0
      link_to 'Asignar cubículo', new_academics_student_request_event_path(student_request)
    else
      link_to 'Modificar cubículo asignado', academics_student_request_event_path(:student_request_id => student_request.id, :id => student_request.event.id)
    end
  end

  def add_child_link(name, association)
    link_to "Agregar", "#",  :"data-association" => association, :class => "add_child"
  end

  def new_child_fields_template(form_builder, association, options = {})
    options[:object] ||= form_builder.object.class.reflect_on_association(association).klass.new
    options[:partial] ||= association.to_s.singularize
    options[:form_builder_local] ||= :f
    content_tag(:div, :id => "#{association}_fields_template", :style => "display: none", :class => 'fields_template') do
      form_builder.fields_for(association, options[:object], :child_index => "new_#{association}") do |f|
        render(:partial => options[:partial], :locals => {options[:form_builder_local] => f, :object_id => options[:object_id]})
      end
    end
  end

  def remove_child_link(f)
    html_class = f.object.new_record? ? "remove_new_child" : "remove_existent_child"
    f.hidden_field(:_destroy, :class => :destroy) + link_to("Borrar", "#", :class => html_class, :confirm => "¿ Desea borrar este elemento ?")
  end
  
  def day_list
    %w(Lunes Martes Miércoles Jueves Viernes)
  end
  
  def day_collection
    day_list = day_list
    day_list.each_index.collect {|i| [day_list[i], i]}
  end
  
  def day_list_builder(f)
    day_list.each_index do |d|
      if f.object.new_record?
        f.object.event_days << EventDay.new(:day => d)
      else
        if object.event_days.where(:day => d).first.nil?
          f.object.event_days << EventDay.new(:day => d)
        end
      end
    end
  end  
end



