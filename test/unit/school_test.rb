require File.dirname(__FILE__) + '/../test_helper'

class SchoolTest < ActiveSupport::TestCase
  fixtures :countries, :institutions, :schools
  should_require_attributes :name
  should_only_allow_numeric_values_for :id
  should_not_allow_values_for :id, -1,  :message => /must be greater than 0/
  should_not_allow_values_for :id, 0,  :message => /must be greater than 0/
  should_allow_nil_value_for :id
  should_not_allow_float_number_for :id

  should_only_allow_numeric_values_for :institution_id
  should_not_allow_values_for :institution_id, -1,  :message => /must be greater than 0/
  should_not_allow_values_for :institution_id, 0,  :message => /must be greater than 0/
  should_not_allow_float_number_for :institution_id

  should_belong_to :institution
  should_have_many :careers
end
