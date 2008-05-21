class Tree < ActiveRecord::Base
  acts_as_nested_set #:scope => :root
end
