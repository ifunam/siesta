require 'rubygems'
require 'activeresource'
class Adscription < ActiveResource::Base
  self.site = 'http://salva.fisica.unam.mx/'

  def self.find_users_by_id(id)
    i = 0
    Adscription.get("users/#{id}").collect { |h|
      unless User.find_by_email(h['email']).nil?
        [ %w(lastname1 lastname2 firstname).collect {|k| h['person'][k] }.join(' '), User.find_by_email(h['email']).id]
      end
      }.compact.sort {|a, b| a[i] <=> b[i]}
  end
end