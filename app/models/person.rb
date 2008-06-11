class Person < ActiveRecord::Base
  validates_numericality_of :id, :allow_nil => true, :only_integer => true, :greater_than => 0
  validates_presence_of :firstname, :lastname1, :birthdate, :country_id
  validates_numericality_of :country_id, :greater_than => 0, :only_integer => true
  validates_numericality_of :city_id, :state_id, :user_id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_inclusion_of :gender, :in => [true, false]
  validates_uniqueness_of :user_id

  def fullname
    [self.lastname1.strip, (self.lastname2 != nil ? self.lastname2.strip : nil), self.firstname].compact.join(' ')
  end

  def placeofbirth
    [self.city.name,  self.state.name, self.country.name].compact.join(', ')
  end

  def validate
    errors.add(:birthdate, 'You should use a birthdate greather than 15') if  !birthdate.nil? and birthdate.to_date > (Date.today - (365 * 15))
  end

  belongs_to :user
  belongs_to :country
  belongs_to :state
  belongs_to :city
end
