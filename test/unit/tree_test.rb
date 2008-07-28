# -*- coding: utf-8 -*-
require File.dirname(__FILE__) + '/../test_helper'
require 'tree'

class TreeTest < ActiveSupport::TestCase
  fixtures :trees
  def test_should_have_installed_acts_as_tree_plugin
    assert File.exist?(File.dirname(__FILE__) + '/../../vendor/plugins/acts_as_tree/lib/active_record/acts/tree.rb'), "You should install acts_as_tree plugin"
  end
  
  should_require_attributes :data
  should_only_allow_numeric_values_for :id, :pos, :root_id
  should_not_allow_zero_or_negative_number_for :id, :pos, :root_id
  should_not_allow_float_number_for :id, :pos, :root_id
  should_allow_nil_value_for :id, :pos, :root_id
end
