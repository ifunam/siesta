class Building < ActiveRecord::Base
  attr_accessible :name
  validates_presence_of :name
  validates_uniqueness_of :name
  has_many :office_cubicles

  default_scope :order => 'name ASC'

end
