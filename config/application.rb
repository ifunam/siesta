require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Auto-require default libraries and those for the current Rails environment.
Bundler.require :default, Rails.env 

module Siesta
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Add additional load paths for your own custom dirs
    config.load_paths += %W( #{config.root}/lib #{config.root}/lib/clients )

    # Only load the plugins named here, in the order given (default is alphabetical).
    # :all can be used as a placeholder for all plugins not explicitly named
    # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

    # Activate observers that should always be running
    # config.active_record.observers = :cacher, :garbage_collector, :forum_observer
    config.active_record.observers = :user_observer, :user_request_observer

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    config.time_zone = 'Mexico City'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    config.i18n.load_path << Dir[Rails.root.join('my', 'locales', '**', '*.{rb,yml}').to_s]
    config.i18n.default_locale = :es

    # Configure generators values. Many other options are available, be sure to check the documentation.
    config.generators do |g|
      g.orm             :active_record
      g.template_engine :haml
      g.test_framework :rspec, :fixture => true, :views => false
      g.fixture_replacement :factory_girl, :dir => "spec/factories"
    end

    config.action_mailer do |am|
      am.default_url_options = { :host => "siesta.fisica.unam.mx" }
      am.action_mailer.delivery_method = :sendmail
      am.action_mailer.sendmail_settings = {
          :location       => '/usr/sbin/sendmail',
          :arguments      => '-i -t -f noreply@fisica.unam.mx'
       }
    end

    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters << :password
    config.filter_parameters << :password_confirmation
  end
end
