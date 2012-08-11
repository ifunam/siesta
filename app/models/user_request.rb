# encoding: utf-8
class UserRequest < ActiveRecord::Base
    attr_accessible :role_id, :remote_user_incharge_id, :remote_adscription_id, :start_month, :end_month, :start_year, :end_year, :is_restamped, 
                    :office, :activities, :want_office_cubicle

    validates_presence_of  :role_id, :remote_user_incharge_id, :remote_adscription_id, :start_month, :end_month, :start_year, :end_year, :is_restamped
    validates_numericality_of :role_id, :remote_user_incharge_id, :remote_adscription_id, :greater_than => 0, :only_integer => true
    validates_numericality_of :period_id, :id, :user_id, :allow_nil => true, :greater_than => 0, :only_integer => true
    validates_uniqueness_of :period_id, :scope => [:user_id]
    validates_inclusion_of :is_restamped, :in => [true, false]
    validates_inclusion_of :is_official, :in => [true, false]

    belongs_to :user, :class_name => "User", :foreign_key => "user_id"
    belongs_to :period
    belongs_to :role
    belongs_to :requeststatus
    belongs_to :adscription, :class_name => 'AdscriptionClient', :foreign_key => 'remote_adscription_id'
    belongs_to :remote_adscription, :class_name => 'AdscriptionClient', :foreign_key => 'remote_adscription_id'
    belongs_to :user_incharge, :class_name => "AcademicClient", :foreign_key => 'remote_user_incharge_id'
    belongs_to :local_user_incharge, :class_name => "User", :foreign_key => 'user_incharge_id'
    has_one :event
    has_many :events

    default_scope includes(:period).order('periods.startdate DESC')

    scope :find_sent_request_to_user_id, lambda { |user_id|
        where("user_requests.remote_user_incharge_id = ? AND user_requests.requeststatus_id <= 3 
               AND user_requests.period_id = ? ", user_id, Period.activated.id).includes(:period).
               order('periods.startdate DESC')
    }

    def self.find_by_academic_login(login)
      user_incharge = AcademicClient.find_by_login(login)
      unless user_incharge.nil?
        select('DISTINCT(user_id)').where(["(period_id = ?) AND remote_user_incharge_id = ? AND requeststatus_id = 3",  Period.most_recent.id, user_incharge.id]).all.collect { |record|
            where(:user_id => record.user_id).includes(:period).order('periods.startdate DESC').limit(1).first
        }.compact
      end
    end

    def send_request
      change_requeststatus(2)
    end

    def type
      is_restamped ? 'Resello' : 'Solicitud nueva'
    end

    def status
      is_official ? 'Autorizada por CD-IF' : 'Sin autorización de la CD-IF'
    end

    def is_unauthorized?
      requeststatus_id != 3
    end

    private

    def change_requeststatus(id)
      self.requeststatus_id = id
      save(true)
    end
end
