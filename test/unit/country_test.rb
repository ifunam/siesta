require File.dirname(__FILE__) + '/../test_helper'

class CountryTest < ActiveSupport::TestCase
  fixtures :countries, :states, :institutions
  should_only_allow_numeric_values_for :id
  should_not_allow_zero_or_negative_number_for :id
  should_not_allow_nil_value_for :id
  should_not_allow_float_number_for :id
  should_require_attributes :name, :citizen, :code
  should_require_unique_attributes :name, :citizen, :code
  
  should_have_many :states
  should_have_many :institutions
end
