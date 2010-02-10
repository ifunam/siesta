class Person < ActiveRecord::Base
  validates_numericality_of :id, :allow_nil => true, :only_integer => true, :greater_than => 0
  validates_presence_of :firstname, :lastname1, :birthdate, :country_id
  validates_numericality_of :country_id, :greater_than => 0, :only_integer => true
  validates_numericality_of :city_id, :state_id, :user_id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_inclusion_of :gender, :in => [true, false]
  validates_uniqueness_of :user_id

  def fullname
    [lastname1.strip, (lastname2 != nil ? lastname2.strip : nil), firstname].compact.join(' ')
  end

  def placeofbirth
    [city.name,  state.name, country.name].compact.join(', ')
  end

  def validate
    errors.add(:birthdate, 'You should use a birthdate greather than 15') if  !birthdate.nil? and birthdate.to_date > (Date.today - (365 * 15))
  end

  belongs_to :user
  belongs_to :country
  belongs_to :state
  belongs_to :city
end
