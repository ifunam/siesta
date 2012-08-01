class Account < ActiveRecord::Base
  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  set_table_name 'users'
  devise :database_authenticatable, :registerable, :recoverable,
         :rememberable, :trackable, :validatable, :encryptable
  validates :login, :uniqueness => true
  validates :email, :uniqueness => true
end
