class Manager < ActiveRecord::Base
  set_table_name 'users'
  devise :ldap_authenticatable
end
