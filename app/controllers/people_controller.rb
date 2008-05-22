class PeopleController < RecordController
  def initialize
    @model = Person
    super
  end
end

