class Event < ActiveRecord::Base
  validates :start_at, :end_at, :presence => true
  belongs_to :user_request
  belongs_to :office_cubicle
  belongs_to :user_incharge, :class_name => "AcademicClient", :foreign_key => 'remote_user_incharge_id'
  has_many :event_days
  accepts_nested_attributes_for :event_days, :allow_destroy => true
end
