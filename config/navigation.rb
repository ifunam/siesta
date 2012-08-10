# -*- coding: utf-8 -*-
# Configures your navigation
SimpleNavigation::Configuration.run do |navigation|
  # Specify a custom renderer if needed.
  # The default renderer is SimpleNavigation::Renderer::List which renders HTML lists.
  # The renderer can also be specified as option in the render_navigation call.
  # navigation.renderer = Your::Custom::Renderer

  # Specify the class that will be applied to active navigation items. Defaults to 'selected'
  # navigation.selected_class = 'your_selected_class'

  # Specify the class that will be applied to the current leaf of
  # active navigation items. Defaults to 'simple-navigation-active-leaf'
  navigation.active_leaf_class = 'active'

  # Item keys are normally added to list items as id.
  # This setting turns that off
  # navigation.autogenerate_item_ids = false

  # You can override the default logic that is used to autogenerate the item ids.
  # To do this, define a Proc which takes the key of the current item as argument.
  # The example below would add a prefix to each key.
  # navigation.id_generator = Proc.new {|key| "my-prefix-#{key}"}

  # If you need to add custom html around item names, you can define a proc that will be called with the name you pass in to the navigation.
  # The example below shows how to wrap items spans.
  # navigation.name_generator = Proc.new {|name| "<span>#{name}</span>"}

  # The auto highlight feature is turned on by default.
  # This turns it off globally (for the whole plugin)
  # navigation.auto_highlight = false
  def label_tag(label_name, icon_class=nil)
    unless icon_class.nil?
      "<i class=\"#{icon_class}\"></i> " + t("navigation.#{label_name}")
    else
      t("navigation.#{label_name}")
    end
  end

  navigation.items do |primary|
    primary.item :profile,  label_tag(:profile, 'icon-user'), profile_path
    primary.item :schoolings, label_tag(:schoolings, 'icon-star'), schoolings_path
    primary.item :user_documents, label_tag(:user_documents, 'icon-hdd'), user_documents_path
    primary.item :user_requests, label_tag(:user_requests, 'icon-book'), user_requests_path
    primary.dom_id = 'menu-id'
    primary.dom_class = 'nav nav-pills nav-stacked'
  end
end
