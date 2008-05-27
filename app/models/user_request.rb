class UserRequest < ActiveRecord::Base
    validates_presence_of :period_id, :role_id, :user_incharge_id, :is_restamped
    validates_numericality_of :period_id, :role_id, :user_incharge_id, :greater_than => 0, :only_integer => true
    validates_uniqueness_of :period_id, :scope => [:user_id]
    
    belongs_to :user
    belongs_to :period
    belongs_to :role
    belongs_to :user_incharge, :class_name => "User", :foreign_key => "user_incharge_id"
end
