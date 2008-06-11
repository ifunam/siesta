class Career < ActiveRecord::Base
  validates_presence_of :name, :degree_id
  validates_numericality_of :degree_id, :greater_than => 0, :only_integer => true
  validates_numericality_of :id, :school_id, :greater_than => 0, :only_integer => true, :allow_nil => true
  validates_uniqueness_of :name, :scope => [:degree_id, :school_id]
  belongs_to :school
  belongs_to :degree

  has_many :schoolings
end
