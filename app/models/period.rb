class Period < ActiveRecord::Base
  validates_numericality_of :id, :allow_nil => true, :only_integer => true, :greater_than => 0
  validates_presence_of :name, :startdate, :enddate
  validates_inclusion_of :is_active, :in=> [true, false]
  validates_uniqueness_of :name

  def validate
   if startdate && enddate
      errors.add("startdate", "must be after checkout") if time_at_midnight(startdate) >= time_at_midnight(enddate)
    end
  end

  def self.most_recent
    Period.get_active || Period.get_last
  end

  def self.get_last
    self.find_by_is_active(false, :order => "startdate DESC")
  end

  def self.get_active
      self.find_by_is_active(true)
  end

  private
  def time_at_midnight(date)
    date.to_date
  end

end
