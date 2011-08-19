class Academic < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  set_table_name 'users'
  devise :ldap_authenticatable
end
