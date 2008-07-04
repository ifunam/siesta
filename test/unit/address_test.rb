# -*- coding: utf-8 -*-
require File.dirname(__FILE__) + '/../test_helper'
class AddressTest < ActiveSupport::TestCase
  fixtures :countries, :states, :cities, :users, :addresstypes, :addresses

  should_require_attributes  :country_id, :location, :addresstype_id
  should_only_allow_numeric_values_for :id, :user_id, :country_id
  should_not_allow_zero_or_negative_number_for :id, :user_id, :country_id, :state_id, :city_id
  should_not_allow_float_number_for :id, :user_id, :country_id, :state_id, :city_id
  should_allow_values_for :is_postaddress, true, false
   
  should_allow_nil_value_for :id, :city_id, :phone, :fax, :movil
  
  should_belong_to :country
  should_belong_to :state
  should_belong_to :city
  should_belong_to :user
  
  context "An Address" do
    # This context was implemented to tests the constraint:
    # validates_uniqueness_of :addresstype_id, :scope => [:user_id]
    setup do
      @record = Address.build_valid
    end
    
    should "use a unique addresstype per user" do
        @record.addresstype_id = 2 # Changing id from fixtures
        @record.user_id = 2 # Using same user_id from fixtures
        assert @record.valid?
    end
     
    should "not use a duplicate addresstype per user" do
         @record.addresstype_id = 1 # Using id from fixtures
         @record.user_id = 2 # Using same user_id from fixtures
         assert !@record.valid?
    end
  end

end
