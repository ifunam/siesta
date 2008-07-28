class Tree < ActiveRecord::Base
  validates_presence_of :data
  validates_numericality_of :id, :parent_id, :pos, :root_id, :allow_nil => true, :greater_than => 0, :only_integer => true
  acts_as_nested_set #:scope => :root
end
