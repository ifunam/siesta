class OfficeCubicle < ActiveRecord::Base
  validates_presence_of  :name_or_number
  belongs_to :building
  belongs_to :cubicle_type

  def as_text
    "#{cubicle_type.name}: #{name_or_number}, Edificio #{building.name}"
  end
end