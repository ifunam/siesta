class UserRequest < ActiveRecord::Base
    validates_presence_of  :user_id, :period_id, :role_id, :remote_user_incharge_id, :remote_adscription_id
    validates_numericality_of :period_id, :role_id, :remote_user_incharge_id, :greater_than => 0, :only_integer => true
    validates_numericality_of :id, :user_id, :allow_nil => true, :greater_than => 0, :only_integer => true
    validates_uniqueness_of :period_id, :scope => [:user_id]
    validates_inclusion_of :is_restamped, :in => [true, false]
    validates_inclusion_of :is_official, :in => [true, false]
    
    belongs_to :user, :class_name => "User", :foreign_key => "user_id"
    belongs_to :period
    belongs_to :role
    belongs_to :requeststatus
    belongs_to :adscription, :class_name => 'AdscriptionClient', :foreign_key => 'remote_adscription_id'
    belongs_to :user_incharge, :class_name => "AcademicClient", :foreign_key => 'remote_user_incharge_id'
    belongs_to :local_user_incharge, :class_name => "User", :foreign_key => 'user_incharge_id'

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

    def is_unauthorized?
      requeststatus_id != 3
    end

    private
    
    def change_requeststatus(id)
      self.requeststatus_id = id
      save(true)
    end
end
