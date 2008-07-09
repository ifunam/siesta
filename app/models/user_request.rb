class UserRequest < ActiveRecord::Base
    validates_presence_of :period_id, :role_id, :user_incharge_id, :is_restamped
    validates_numericality_of :period_id, :role_id, :user_incharge_id, :greater_than => 0, :only_integer => true
    validates_uniqueness_of :period_id, :scope => [:user_id]

    belongs_to :user
    belongs_to :period
    belongs_to :role
    belongs_to :requeststatus
    belongs_to :user_incharge, :class_name => "User", :foreign_key => "user_incharge_id"

    after_save :set_user_incharge
    after_destroy :unset_user_incharge
    
    named_scope :search, lambda{ |user_incharge_id, period_id| { :conditions => ['user_incharge_id = ? AND period_id = ?', user_incharge_id, period_id] } }
    
    def send_request
      self.requeststatus_id  = 2
      save(true)
    end
    
    def set_user_incharge
      @user = User.find(self.user_id)
      @user.update_attribute('user_incharge_id', self.user_incharge_id)
    end

    def unset_user_incharge
      @user = User.find(self.user_id)
      @user.update_attribute('user_incharge_id', nil)
    end
end
