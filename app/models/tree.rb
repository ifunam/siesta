class Tree < ActiveRecord::Base
#  validates_numericality_of :parent_id, :pos, :lft, :rgt, :root_id, :allow_nil => true, :greater_than => 0, :only_integer => true
  acts_as_nested_set #:scope => :root
end
