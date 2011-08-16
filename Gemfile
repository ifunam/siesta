# Edit this Gemfile to bundle your application's dependencies.
source :gemcutter

gem "rails", "~> 3.0.9"

gem "haml", "~> 3.1.2"
gem "pg", "~> 0.11.0"
gem "compass", "~> 0.11.5"
gem "warden", "~> 1.0.5"
gem "devise", "~> 1.4.0" #, :path => 'tmp/devise-1.1.2'
gem "devise_ldap_authenticatable", "~> 0.4.9"
gem "net-ldap", "~> 0.2.2"

gem "ssl_requirement", "~> 0.1.0"
gem "paperclip", "~> 2.3.16"
gem "will_paginate", "~> 3.0.0"
gem "rmagick", "~> 2.13.1", :require => 'RMagick'
gem "rqrcode", "~> 0.4.1"
gem "barby", "~> 0.4.4"
gem "bcrypt-ruby", "~> 2.1.4"
gem "tzinfo", "~> 0.3.29"
gem "inherited_resources", "~> 1.2.2"
gem "cancan", "~> 1.6.5"
gem "meta_search", "~> 1.0.6"
gem "meta_where", "~> 1.0.4"
gem "scope_by_fuzzy", "~> 0.0.2"

group :production do
  gem "rack-ssl-enforcer", "~> 0.2.3", :require => 'rack/ssl-enforcer'
  gem "inploy", "~> 1.9.4"
end

group :development do
  # DB performance tools
  gem "bullet", "~> 2.0.1"
  gem "slim_scrooge", "~> 1.0.11"
  gem "hpricot", "~> 0.8.4"
  gem "ruby_parser", "~> 2.1.0"
end

group :test do
  gem "rspec-rails", "~> 2.6.1"
  gem "factory_girl", "~> 2.0.4"
end
