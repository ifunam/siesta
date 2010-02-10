class School < ActiveRecord::Base
  validates_presence_of :name
  validates_numericality_of :id, :institution_id, :greater_than => 0, :only_integer => true, :allow_nil => true
  validates_uniqueness_of :name, :scope => [:institution_id]
  belongs_to :institution
  has_many :careers
end
