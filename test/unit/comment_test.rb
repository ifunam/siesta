require File.dirname(__FILE__) + '/../test_helper'

class CommentTest < ActiveSupport::TestCase
  fixtures :userstatuses, :users, :periods, :roles, :user_requests, :comments
  
  should_require_attributes :user_id, :subject, :body
  should_only_allow_numeric_values_for :id, :user_id, :user_request_id, :parent_id
  should_not_allow_zero_or_negative_number_for :id, :user_id, :user_request_id, :parent_id
  should_allow_nil_value_for :id, :user_request_id, :parent_id
  should_not_allow_float_number_for :id, :user_id, :user_request_id, :parent_id

  should_belong_to :user_request
  should_belong_to :user
  should_belong_to :parent
end
