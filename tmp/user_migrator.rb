require 'rubygems'
require 'active_record'

$config = {
  :siesta_current => { :adapter => "postgresql", :database => 'salva',  :username => "alex", :password => nil, :host => "siesta.fisica.unam.mx" },
  :siesta => { :adapter => "postgresql", :database => 'siesta',  :username => "alex", :password => nil, :host => "localhost" }
}
module SiestaCurrent
  class User < ActiveRecord::Base
    establish_connection $config[:siesta_current]
  end
end

module Siesta
  class User < ActiveRecord::Base
    establish_connection $config[:siesta] 
  end
end

SiestaCurrent::User.find(:all, :conditions => 'users.id > 3', :order => 'users.id ASC').each do |record|
  if Siesta::User.find_by_login(record.login).nil? && Siesta::User.find_by_email(record.email).nil?
    @user = Siesta::User.new(:login => record.login, :email => record.email, :passwd => 'maltiempo')
    @user.id = record.id
    @user.save if @user.valid?
  end  
end