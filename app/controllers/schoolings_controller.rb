class SchoolingsController < SharedController
  def initialize
    @model = Schooling
    super
    @columns = %w( degree career school institution studentid credits average startmonth startyear endmonth endyear is_studying_this is_titleholder )
  end
end
