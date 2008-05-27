class Period < ActiveRecord::Base
  validates_numericality_of :id, :allow_nil => true, :only_integer => true, :greater_than => 0  
  validates_presence_of :name, :startdate, :enddate
  validates_inclusion_of :is_active, :in=> [true, false]
  validates_uniqueness_of :name
  
  # named_scope :most_recent, prepare this to work with rails 2.1
  class << self
    def get_most_recent
      Period.get_active || Period.get_last
    end

    def get_last
      self.find(:first, :order => 'startdate DESC')
    end

    def get_active
      self.find(:first, :conditions => "is_active = 't'")
    end
  end
  
end
