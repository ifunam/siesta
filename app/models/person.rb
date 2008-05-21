class Person < ActiveRecord::Base
  validates_presence_of :firstname, :lastname1, :birthdate, :country_id
  validates_numericality_of :country_id, :greater_than => 0, :only_integer => true
  validates_numericality_of :city_id, :state_id, :user_id,   :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_inclusion_of :gender, :in => [true, false]
  validates_uniqueness_of :user_id

  def fullname
    [self.lastname1.strip, (self.lastname2 != nil ? self.lastname2.strip : nil), self.firstname].compact.join(' ')
  end

  def placeofbirth
    [self.city.name,  self.state.name, self.country.name].compact.join(', ')
  end

  belongs_to :user
  belongs_to :country
  belongs_to :state
  belongs_to :city
end
