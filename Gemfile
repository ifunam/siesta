# Edit this Gemfile to bundle your application's dependencies.
source 'http://gemcutter.org'

gem "rails", "3.0.0.beta"

# ActiveRecord requires a database adapter. By default,
# Rails has selected sqlite3.
gem "pg"
gem "haml-edge", "2.3.155", :require => 'haml'
gem "compass", "0.10.0.pre5", :git => "git://github.com/chriseppstein/compass.git", :branch => 'master'
gem "authlogic", "2.1.3", :git => "git://github.com/binarylogic/authlogic.git", :branch => 'master'
#gem "paperclip"

group :development do
  # DB performance tools
  gem "bullet"
  gem "rails_indexes", "0.0.0", :git => "git://github.com/eladmeidar/rails_indexes.git", :branch => "master"
#  gem "methodmissing-scrooge", :source => "http://gems.github.com"
end

group :test do
  gem "rspec"
  gem "rspec-rails"
end

# compass --rails -f blueprint --sass-dir=app/sass --css-dir=public/stylesheets  --javascript-dir=public/javascripts --images-dir=public/images 
