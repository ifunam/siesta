class Country < ActiveRecord::Base
  @@whiny_protected_attributes = false
  validates_presence_of  :name, :citizen, :code
  validates_numericality_of :id, :greater_than => 0, :only_integer => true
  validates_uniqueness_of :name, :code
end
