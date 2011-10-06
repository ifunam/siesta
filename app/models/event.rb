# encoding: utf-8
class Event < ActiveRecord::Base
  validates :start_at, :end_at, :presence => true
  belongs_to :user_request
  belongs_to :office_cubicle
  belongs_to :user_incharge, :class_name => "AcademicClient", :foreign_key => 'remote_user_incharge_id'
  has_many :event_days
  accepts_nested_attributes_for :event_days, :allow_destroy => true

  scope :all_by_activated_period, includes(:user_request).where(:user_requests => {:period_id => Period.activated.id})
  scope :before, lambda {|end_time| {:conditions => ["end_at < ?", Event.format_date(end_time)] }}
  scope :after, lambda {|start_time| {:conditions => ["start_at > ?", Event.format_date(start_time)] }}

  def self.format_date(date_time)
    Time.at(date_time.to_i).to_formatted_s(:db)
  end

  def student
    user_request.user.person.fullname
  end

  def description
    "Calendario para el estudiante #{student} en el  #{office_cubicle.as_text}, Periodo: #{user_request.period.name}"
  end


  def event_days_as_json
    (self.start_at.to_date..self.end_at.to_date).collect { |date|
      if event_days.collect(&:day).include? date.wday
        event_day = event_days.where(:day => date.wday).first
        {
        :id => self.id,
        :title => student,
        :description => description,
        :start => DateTime.new(date.year, date.month, date.day, event_day.start_at.hour, event_day.start_at.min, 0).rfc822,
        :end => DateTime.new(date.year, date.month, date.day, event_day.end_at.hour, event_day.end_at.min, 0).rfc822,
        :allDay => false,
        :recurring => false,
        :url => Rails.application.routes.url_helpers.academics_event_path(self.id)
        }
      end
    }.compact
  end
end
