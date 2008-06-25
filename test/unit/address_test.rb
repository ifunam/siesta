# -*- coding: utf-8 -*-
require File.dirname(__FILE__) + '/../test_helper'
class AddressTest < ActiveSupport::TestCase
  fixtures :countries, :states, :cities, :users, :addresses

  should_require_attributes  :country_id,  :location, :addresstype_id
  should_only_allow_numeric_values_for :id, :user_id, :country_id
  should_not_allow_zero_or_negative_number_for :id, :user_id, :country_id, :state_id, :city_id
  should_not_allow_float_number_for :id, :user_id, :country_id, :state_id, :city_id
  should_allow_values_for :is_postaddress, true, false
  should_require_unique_attributes :addresstype_id, :scoped_to => :user_id
  should_allow_nil_value_for :id, :city_id, :phone, :fax, :movil

  should_belong_to :country
  should_belong_to :state
  should_belong_to :city
  should_belong_to :user
end
