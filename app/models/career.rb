class Career < ActiveRecord::Base
  validates_presence_of :name
  validates_numericality_of :degree_id
  validates_uniqueness_of :name, :scope => [:degree_id, :school_id]
  belongs_to :school
  belongs_to :degree
end
