class Period < ActiveRecord::Base
  validates_numericality_of :id, :allow_nil => true, :only_integer => true, :greater_than => 0  
  validates_presence_of :name, :startdate, :enddate
  validates_inclusion_of :is_active, :in=> [true, false]
  validates_uniqueness_of :name
  
  def self.get_most_recent
    Period.get_active || Period.get_last
  end

  def self.get_last
      self.find(:first, :order => 'startdate DESC')
  end

  def self.get_active
      self.find(:first, :conditions => "is_active = 't'")
  end
end
