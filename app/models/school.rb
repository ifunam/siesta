class School < ActiveRecord::Base
  validates_presence_of :name
  validates_uniqueness_of :name, :scope => [:institution_id]
  belongs_to :institution
end
