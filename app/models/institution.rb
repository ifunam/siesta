class Institution < ActiveRecord::Base
  validates_presence_of :name, :country_id
  validates_numericality_of :country_id, :greater_than => 0, :only_integer => true
  belongs_to :parent, :class_name => 'Institution', :foreign_key => 'parent_id'
  #acts_as_tree
end
