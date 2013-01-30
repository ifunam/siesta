class DisabilityType < ActiveRecord::Base
  attr_accessible :name
  has_many :disabilities
  default_scope :order => 'name ASC'
end
