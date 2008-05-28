class Schooling < ActiveRecord::Base
  validates_presence_of :career_id, :average, :credits, :startmonth, :startyear
  validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of :user_id, :career_id, :greater_than => 0, :only_integer => true
  validates_numericality_of :average, :greater_than => 5.9, :less_than_or_equal_to => 10
  validates_numericality_of :credits, :greater_than => 0, :less_than_or_equal_to => 100, :only_integer => true
  validates_numericality_of :startmonth, :greater_than => 0, :less_than_or_equal_to => 12, :only_integer => true
  validates_numericality_of :startyear, :greater_than => (Date.today.year.to_i - 50), :less_than_or_equal_to => Date.today.year.to_i, :only_integer => true
  validates_numericality_of :endmonth,  :greater_than => 0, :less_than_or_equal_to => 12, :only_integer => true, :allow_nil => true
  # FIXME: This can cause some problems
  validates_numericality_of :endyear, :greater_than => (Date.today.year.to_i - 50), :only_integer => true, :allow_nil => true
  validates_uniqueness_of :career_id, :scope => [:user_id]

  belongs_to :user
  belongs_to :career

  def degree_name
    self.career.degree.name
  end

  def career_and_institution
    [career_name, institution_name].join(', ')
  end

  def career_name
    self.career.name
  end

  def institution_name
    values = [ self.career.institution.name ]
    values << self.career.institution.parent.name if !self.career.institution.parent.nil?
    values.join(', ')
  end
end
