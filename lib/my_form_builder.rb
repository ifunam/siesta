class MyFormBuilder < ActionView::Helpers::FormBuilder
  include ActionView::Helpers::TagHelper
  include ActionView::Helpers::CaptureHelper
  # include ActionView::Helpers::TranslationHelper

  include ERB::Util
  
  (field_helpers + [:collection_select, :file_field]).each do |selector|
    src = <<-end_src
    def #{selector}(method, *args)
      label_key = '.' + method.to_s
      options = args.last
      unless "#{selector}" == 'hidden_field' or "#{selector}" == 'radio_button'
        if options.is_a? Hash and options.has_key? :blueprint
          @template.content_tag(:div, @template.label(@object_name, method, I18n.t(label_key)) + super, :class => options[:blueprint])
        else
          @template.label(@object_name, method, I18n.t(label_key)) + super
        end
      else
        super
      end
    end 
    end_src
    class_eval src, __FILE__, __LINE__
  end
end
