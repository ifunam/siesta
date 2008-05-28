class Adscription < ActiveResource::Base
 self.site = 'http://salva.fisica.unam.mx/'

 def self.find_users(id)
   i = 0
   self.get("users/#{id}").collect { |h|
     unless User.find_by_email(h['user']['email']).nil?
       [ %w(lastname1 lastname2 firstname).collect {|k| h['user']['person'][k] }.join(' '), User.find_by_email(h['user']['email']).id]
     end
  }.compact.sort {|a, b|  a[i] <=> b[i]  }
 end
end
