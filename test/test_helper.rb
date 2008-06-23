ENV["RAILS_ENV"] = "test"
require File.expand_path(File.dirname(__FILE__) + "/../config/environment")
require 'test_help'
require File.dirname(__FILE__) + "/factory"
require 'flexmock/test_unit'

class Test::Unit::TestCase
  # Transactional fixtures accelerate your tests by wrapping each test method
  # in a transaction that's rolled back on completion.  This ensures that the
  # test database remains unchanged so your fixtures don't have to be reloaded
  # between every test method.  Fewer database queries means faster tests.
  #
  # Read Mike Clark's excellent walkthrough at
  #   http://clarkware.com/cgi/blosxom/2005/10/24#Rails10FastTesting
  #
  # Every Active Record database supports transactions except MyISAM tables
  # in MySQL.  Turn off transactional fixtures in this case; however, if you
  # don't care one way or the other, switching from MyISAM to InnoDB tables
  # is recommended.
  #
  # The only drawback to using transactional fixtures is when you actually
  # need to test transactions.  Since your test is bracketed by a transaction,
  # any transactions started in your code will be automatically rolled back.
  self.use_transactional_fixtures = true

  # Instantiated fixtures are slow, but give you @david where otherwise you
  # would need people(:david).  If you don't want to migrate your existing
  # test cases which use the @david style and don't mind the speed hit (each
  # instantiated fixtures translates to a database query per test method),
  # then set this back to true.
  self.use_instantiated_fixtures  = false

  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all
  
  module Shoulda # :nodoc: all
    module Extensions 
        include Test::Unit::Assertions
        def should_allow_nil_value_for(attribute)
            record = make_model
            record.send("#{attribute}=", nil)
            assert record.valid?, get_errors(record) 
        end
      
        def should_not_allow_nil_value_for(attribute)
             record = make_model
             record.send("#{attribute}=", nil)
             assert !record.valid?, get_errors(record)
        end
        
        def should_not_allow_float_number_for(attribute)
             record = make_model
             record.send("#{attribute}=", 1.01)
             assert !record.valid?, get_errors(record)
        end
        
        private
        def make_model_with(new_options={})
            make_model {|options| options.merge!(new_options)}
        end
         
        def make_model_without(field)
            make_model {|options| options.delete(field) }
        end
        
        def make_model
              model = model_under_test
              options = model.valid_options
              yield options if block_given?
              model.new(options)
        end
         
        def model_under_test
            self.to_s.gsub('Test', '').constantize
        end
         
        def get_errors(record)
          "\nErrors:\n" + record.errors.full_messages.join("\n")
        end
    end
  end
  include Shoulda::Extensions
  extend Shoulda::Extensions
  
end
