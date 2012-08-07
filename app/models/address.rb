class Address < ActiveRecord::Base
  attr_accessible :location, :pobox, :phone, :fax, :other, :zipcode, :state_id, :city, :id

  validates_presence_of :location, :city
  validates_numericality_of :id, :state_id,  :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of :user_id, :addresstype_id, :country_id, :greater_than => 0, :only_integer => true, :allow_nil => true
  validates_inclusion_of :is_postaddress, :in=> [true, false]
  validates_uniqueness_of :addresstype_id, :scope => [:user_id]

  belongs_to :country
  belongs_to :addresstype
  belongs_to :state
  belongs_to :user

  before_create :set_address_and_country

  def set_address_and_country
    self.addresstype_id = 1
    self.country_id = 484
  end
end
