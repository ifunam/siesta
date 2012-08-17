# -*- coding: utf-8 -*-
# Configures your navigation
SimpleNavigation::Configuration.run do |navigation|
  navigation.active_leaf_class = 'active'

  def label_tag(label_name, icon_class=nil)
    unless icon_class.nil?
      "<i class=\"#{icon_class}\"></i> " + t("manager_navigation.#{label_name}")
    else
      t("manager_navigation.#{label_name}")
    end
  end

  navigation.items do |primary|
    primary.item :students, label_tag(:students), managers_students_path
    primary.item :periods, label_tag(:periods), managers_periods_path
    primary.dom_id = 'menu-id'
    primary.dom_class = 'nav nav-tabs'
  end
end
