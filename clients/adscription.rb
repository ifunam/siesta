require 'rubygems'
require 'activeresource'
class Adscription < ActiveResource::Base
 self.site = 'http://salva.fisica.unam.mx/'

 def self.users
   i = 0
   self.find(self.id).collect { |h|
     unless User.find_by_email(h['user']['email']).nil?
       [ %w(lastname1 lastname2 firstname).collect {|k| h['user']['person'][k] }.join(' '), User.find_by_email(h['user']['email']).id]
     end
  }.compact.sort {|a, b|  a[i] <=> b[i]  }
 end
end
