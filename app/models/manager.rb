class Manager < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  set_table_name 'users'

  devise :ldap_authenticatable, :trackable, :timeoutable, :lockable
end
