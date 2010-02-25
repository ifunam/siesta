require File.expand_path('../boot', __FILE__)
require 'rails/all'

# Auto-require default libraries and those for the current Rails environment.
Bundler.require :default, Rails.env 

module Siesta
  class Application < Rails::Application
    config.load_paths += %W( #{config.root}/lib #{config.root}/lib/clients )
    config.active_record.observers = :user_observer, :user_request_observer
    config.time_zone = 'Mexico City'
    config.i18n.load_path << Dir[Rails.root.join('my', 'locales', '**', '*.{rb,yml}').to_s]
    config.i18n.default_locale = :es

    config.generators do |g|
      g.orm             :active_record
      g.template_engine :haml
      g.test_framework :rspec, :fixture => true, :views => false
      g.fixture_replacement :factory_girl, :dir => "spec/factories"
    end

    if Rails.env != 'test'
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

      config.middleware.use Rack::Mole, { 
        :moleable    => true,
        :environment => Rails.env,
        :app_name => "SIESTA", 
        :store => Rackamole::Store::MongoDb.new( :db_name => "mole_siesta_#{Rails.env.to_s}_mdb"), 
        :email => { :from => 'noreply@fisica.unam.mx',  :to => ['alex@fisica.unam.mx'], :alert_on => [Rackamole.perf, Rackamole.fault, Rackamole.feature] }
      }
    end
  end
end
