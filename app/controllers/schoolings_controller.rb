class SchoolingsController < SharedController
  def initialize
    @model = Schooling
    super
    @columns = %w( career studentid credits average startyear endyear is_studying_this is_titleholder )
  end
end
