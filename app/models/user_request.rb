class UserRequest < ActiveRecord::Base
    validates_presence_of :period_id, :role_id, :user_incharge_id, :is_restamped
    validates_numericality_of :period_id, :role_id, :user_incharge_id, :greater_than => 0, :only_integer => true
    validates_uniqueness_of :period_id, :scope => [:user_id]

    belongs_to :user
    belongs_to :period
    belongs_to :role
    belongs_to :requeststatus
    belongs_to :user_incharge, :class_name => "User", :foreign_key => "user_incharge_id"

    has_many :comments
    
    after_save :set_user_incharge
    after_destroy :unset_user_incharge

    def self.search(user_incharge_id, period_id, requeststatus_id = nil)
      if requeststatus_id.nil?
        all(:conditions => ['user_incharge_id = ? AND period_id = ?', user_incharge_id, period_id])
      else
        all(:conditions => ['user_incharge_id = ? AND period_id = ? AND requeststatus_id = ?', user_incharge_id, period_id, requeststatus_id])
      end
    end
    
    def send_request
      change_requeststatus(2)
    end
    
    def authorize
      change_requeststatus(3)
    end

    def unauthorize
      change_requeststatus(4)
    end
    
    def set_user_incharge
      @user = User.find(self.user_id)
      @user.update_attribute('user_incharge_id', self.user_incharge_id)
    end

    def unset_user_incharge
      @user = User.find(self.user_id)
      @user.update_attribute('user_incharge_id', nil)
    end
    
    private
    
    def change_requeststatus(id)
      self.requeststatus_id = id
      save(true)
    end
end
