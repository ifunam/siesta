require File.dirname(__FILE__) + '/../test_helper'
class CityTest < ActiveSupport::TestCase
  fixtures :countries, :states, :cities
  
  should_require_attributes :name, :state_id
  should_require_unique_attributes :name, :scoped_to => :state_id

  should_only_allow_numeric_values_for :id
  should_not_allow_zero_or_negative_number_for :id
  should_allow_nil_value_for :id
  should_not_allow_nil_value_for :state_id
  should_not_allow_float_number_for :id, :state_id

  should_belong_to :state
end
