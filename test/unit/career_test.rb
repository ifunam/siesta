require File.dirname(__FILE__) + '/../test_helper'

class CareerTest < ActiveSupport::TestCase
  fixtures :countries, :institutions, :schools, :degrees, :careers

  should_require_attributes :name, :degree_id

  should_only_allow_numeric_values_for :id
  should_not_allow_values_for :id, -1,  :message => /must be greater than 0/
  should_not_allow_values_for :id, 0,  :message => /must be greater than 0/
  should_allow_nil_value_for :id
  should_not_allow_float_number_for :id

  should_only_allow_numeric_values_for :degree_id
  should_not_allow_values_for :degree_id, -1,  :message => /must be greater than 0/
  should_not_allow_values_for :degree_id, 0,  :message => /must be greater than 0/
  should_not_allow_nil_value_for :degree_id
  should_not_allow_float_number_for :degree_id

  should_only_allow_numeric_values_for :school_id
  should_not_allow_values_for :school_id, -1,  :message => /must be greater than 0/
  should_not_allow_values_for :school_id, 0,  :message => /must be greater than 0/
  should_allow_nil_value_for :school_id # You can use @careerd.school = @school
  should_not_allow_float_number_for :school_id

  should_belong_to :school
  should_belong_to :degree
  should_have_many :schoolings
end
