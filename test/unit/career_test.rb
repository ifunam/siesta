require File.dirname(__FILE__) + '/../test_helper'

class CareerTest < ActiveSupport::TestCase
  fixtures :countries, :institutions, :schools, :degrees, :careers

  should_require_attributes :name, :degree_id

  should_only_allow_numeric_values_for :id,  :degree_id, :school_id
  should_allow_nil_value_for :id, :school_id # You could use @career.school = @school
  should_not_allow_float_number_for :id, :degree_id, :school_id
  should_not_allow_zero_or_negative_number_for :id, :degree_id, :school_id

  should_belong_to :school
  should_belong_to :degree
  should_have_many :schoolings
end
