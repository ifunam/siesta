class EventDay < ActiveRecord::Base
  validates_presence_of :start_at, :end_at, :day
  belongs_to :event
end
