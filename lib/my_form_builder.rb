class MyFormBuilder < ActionView::Helpers::FormBuilder
  include ActionView::Helpers::TagHelper
  include ActionView::Helpers::CaptureHelper
  # include ActionView::Helpers::TranslationHelper

  include ERB::Util
  (field_helpers + [:collection_select]).each do |selector|
    src = <<-end_src
    def #{selector}(method, *args)
      label_key = '.' + method.to_s
      options = args.last
      puts @object_name
      if options.is_a? Hash and options.has_key? :blueprint
        @template.content_tag(:div, @template.label(@object_name, method, I18n.t(label_key)) + super, :class => options[:blueprint])
      else
        @template.label(@object_name, method, I18n.t(label_key)) + super
      end
    end 
    end_src
    class_eval src, __FILE__, __LINE__
  end
end
