require 'digest/sha2'
require 'resolv'
class User < ActiveRecord::Base
  acts_as_authentic do |c|
   c.logged_in_timeout = 120.minutes
  end
end
