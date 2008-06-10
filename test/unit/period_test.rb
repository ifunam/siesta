require File.dirname(__FILE__) + '/../test_helper'

class PeriodTest < ActiveSupport::TestCase
  fixtures :periods

  should_require_attributes :name, :startdate, :enddate
  should_require_unique_attributes :name
  should_allow_values_for :is_active, true, false
  should_only_allow_numeric_values_for :id
  should_not_allow_values_for :id, -1,  :message => /must be greater than 0/
  should_not_allow_values_for :id, 0,  :message => /must be greater than 0/

  context "A Period" do
    setup do
      @period = Period.build_valid
    end

    should "be use a valid range of dates" do

      @period.startdate = Date.today
      @period.enddate = Date.tomorrow
      assert @period.valid?

      @period.startdate = Date.yesterday
      @period.enddate = Date.today
      assert @period.valid?

      @period.startdate = Date.yesterday
      @period.enddate = Date.tomorrow
      assert @period.valid?

    end

    should "not be use a invalid range of dates" do
      @period.startdate = Date.today
      @period.enddate = Date.yesterday
      assert !@period.valid?

      @period.startdate = Date.today
      @period.enddate = Date.today
      assert !@period.valid?

      @period.startdate = Date.tomorrow
      @period.enddate = Date.today
      assert !@period.valid?
    end
  end

  def test_should_get_last_period
    assert_equal '2008-2', Period.get_last.name
  end

  def test_should_get_active_period
    assert_equal '2009-1', Period.get_active.name
  end

  def test_should_get_most_recent_period
    assert_equal '2009-1', Period.get_most_recent.name
  end
end


