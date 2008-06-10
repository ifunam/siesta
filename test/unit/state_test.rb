require File.dirname(__FILE__) + '/../test_helper'

class StateTest < ActiveSupport::TestCase
  fixtures :countries, :states
  should_require_attributes :name, :country_id
#  should_require_unique_attributes :name, :scope => [:country_id]
  should_only_allow_numeric_values_for :id
  should_not_allow_values_for :id, -1,  :message => /must be greater than 0/
  should_not_allow_values_for :id, 0,  :message => /must be greater than 0/
  should_belong_to :country
  should_have_many :cities
end
