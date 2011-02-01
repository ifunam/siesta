class Institution < ActiveRecord::Base
  # acts_as_tree

  validates_numericality_of :id, :greater_than => 0, :only_integer => true, :allow_nil => true
  validates_presence_of :name, :country_id
  validates_numericality_of :country_id, :greater_than => 0, :only_integer => true
  validates_uniqueness_of :name, :scope => [:country_id]

  belongs_to :parent, :class_name => 'Institution', :foreign_key => 'parent_id'
  has_many :schools
end
