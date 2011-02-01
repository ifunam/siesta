class User < ActiveRecord::Base
  devise :ldap_authenticatable

  validates :login, :uniqueness => true
  validates :email, :uniqueness => true

  has_one :person
  has_one :address
  has_many :user_documents
  accepts_nested_attributes_for :person, :address, :user_documents

  attr_accessible :person_attributes, :address_attributes, :user_documents_attributes
end
