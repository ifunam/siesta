class Career < ActiveRecord::Base
  validates_presence_of :name
  validates_numericality_of :degree_id

  belongs_to :institution
  belongs_to :degree
end
