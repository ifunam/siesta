class Userstatus < ActiveRecord::Base
    validates_numericality_of :id, :allow_nil => true, :only_integer => true, :greater_than => 0
    validates_presence_of :name
    validates_uniqueness_of :name
end
