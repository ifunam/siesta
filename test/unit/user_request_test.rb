require File.dirname(__FILE__) + '/../test_helper'

class UserRequestTest < ActiveSupport::TestCase
   fixtures :userstatuses, :users, :periods, :roles, :user_requests

   should_require_attributes :period_id, :role_id, :user_incharge_id # :is_restamped
   should_only_allow_numeric_values_for :id, :user_id, :period_id, :role_id, :user_incharge_id
   should_not_allow_zero_or_negative_number_for :id, :user_id, :period_id, :role_id, :user_incharge_id
   should_not_allow_float_number_for :id, :user_id, :period_id, :role_id, :user_incharge_id
   should_allow_only_boolean_for :is_restamped, :is_official

   should_require_unique_attributes :period_id, :scoped_to => :user_id
   
   should_belong_to :user, :period, :role, :user_incharge

   should_have_many :comments
end
