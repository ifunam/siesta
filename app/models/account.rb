class Account < User
  set_table_name 'users'

  devise :database_authenticatable, :registerable, :recoverable,
         :rememberable, :trackable, :validatable, :encryptable,
         :lockable, :authentication_keys => [:email]

  attr_accessible :email, :password, :password_confirmation, :remember_me
end
