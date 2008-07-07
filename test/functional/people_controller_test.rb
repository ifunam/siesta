require File.dirname(__FILE__) + '/../test_helper'
class PeopleControllerTest < ActionController::TestCase     
  fixtures :trees, :userstatuses, :users, :countries, :cities, :states, :people

  context "on GET to :index" do
    setup do
      login_as :alex
      get :index
    end
    should_respond_with :success
    assert_not_nil :person
    should_render_template :show
  end


  
end