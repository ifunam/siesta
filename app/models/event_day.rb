class EventDay < ActiveRecord::Base
  validates_presence_of :start_at, :end_at, :day
  belongs_to :event

  def start_time
    start_at.strftime("%H:%M:%S")
  end
  
  def end_time
    end_at.strftime("%H:%M:%S")
  end
end
