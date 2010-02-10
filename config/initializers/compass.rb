require 'compass'
Compass.configuration.parse(File.join(Rails.root.to_s, "config", "compass.rb"))
Compass.configuration.environment = Rails.env
Compass.configure_sass_plugin!

# added to make sure sass has the sass-cache directory
FileUtils.mkdir_p Rails.root.join("tmp", "sass-cache").to_s
Sass::Plugin.options[:cache_location] ||= Rails.root.join("tmp", "sass-cache").to_s

