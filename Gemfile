# Edit this Gemfile to bundle your application's dependencies.
source :gemcutter

gem "rails", "3.0.4.rc1"

gem "haml", "3.0.25"
gem "pg", "0.10.0"
gem "compass", "0.10.6"
gem "authlogic", "2.1.6"
gem "warden"
gem "devise", "1.1.2", :path => 'tmp/devise-1.1.2'
gem "devise_ldap_authenticatable", "0.4.6"
gem "net-ldap", "0.1.1"
gem "ssl_requirement"
gem "paperclip", "2.3.8"
gem "will_paginate", "3.0.pre2"
gem "rmagick", "2.12.2", :require => 'RMagick'
gem 'barby', "0.4.2"
gem 'bcrypt-ruby', "2.1.4"
gem "tzinfo", "0.3.24"
gem "acts_as_tree", :git => 'git://github.com/parasew/acts_as_tree.git'
gem "inherited_resources", "1.2.1"

group :production do
  gem "rack-ssl-enforcer", "0.2.0", :require => 'rack/ssl-enforcer'
  gem "inploy", "1.9.0"
end

group :development do
  # DB performance tools
  gem "bullet" # Gem to identify N+1 queries and unused eager loading 
  gem "slim_scrooge", "1.0.11"
  gem "hpricot"
  gem "ruby_parser"
end

group :test do
  gem "rspec-rails", "2.4.1"
  gem "factory_girl", "1.3.3"
end
