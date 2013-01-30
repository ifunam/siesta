class Disability < ActiveRecord::Base
  belongs_to :disability_type
  attr_accessible :name

  default_scope order("name ASC")
end
