class Account < ActiveRecord::Base
  set_table_name 'users'
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :encryptable, :encryptor => :sha1, :authentication_keys => [:login]
         
  validates :login, :uniqueness => true
  validates :email, :uniqueness => true
end
