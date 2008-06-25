require File.dirname(__FILE__) + '/../test_helper'

class StateTest < ActiveSupport::TestCase
  fixtures :countries, :states, :cities
  should_require_attributes :name, :country_id
  should_require_unique_attributes :name, :scoped_to => :country_id

  should_only_allow_numeric_values_for :id, :country_id
  should_not_allow_zero_or_negative_number_for :id, :country_id
  should_not_allow_float_number_for :id, :country_id
  should_allow_nil_value_for :id, :code
  should_not_allow_nil_value_for :country_id

  should_belong_to :country
  should_have_many :cities
end
