# -*- coding: utf-8 -*-
require File.dirname(__FILE__) + '/../test_helper'

class PersonTest < ActiveSupport::TestCase
  fixtures :countries, :states, :cities, :users, :people
  should_require_attributes :firstname, :lastname1, :birthdate, :country_id

  should_only_allow_numeric_values_for :id, :user_id, :country_id, :state_id, :city_id
  should_not_allow_zero_or_negative_number_for :id
  should_allow_nil_value_for :id
  should_not_allow_float_number_for :id, :user_id, :country_id, :state_id, :city_id

  should_allow_values_for :gender, true, false
  should_require_unique_attributes :user_id

  def test_fullname
    assert_equal 'Due John', Person.find(:first).fullname
  end

  def test_placeofbirth
    assert_equal 'Aguascalientes, Aguascalientes, México', Person.find(:first).placeofbirth
  end

  def test_invalid_birthdate
    @record = Person.find(:first)
    @record.birthdate = Date.today
    assert !@record.valid?
  end
end
