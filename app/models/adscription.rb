require 'rubygems'
require 'activeresource'
class Adscription < ActiveResource::Base
  self.site = 'http://salva.fisica.unam.mx:8080/'

  def self.find_users_by_id(id)
    i = 0
    Adscription.get("users/#{id}").collect { |h|
      @user = User.find_by_login(h['login'])
      unless User.exists?(:login => h['login'], :email => h['email'])
        @user = User.new(:login => h['login'], :email => h['email'], :passwd => 'qw12..', :passwd_confirmation => 'qw12..')
        @user.save if @user.valid?
      end
        [ %w(lastname1 lastname2 firstname).collect {|k| h['person'][k] }.join(' '), @user.id]

      }.compact.sort {|a, b| a[i] <=> b[i]}
  end
end
