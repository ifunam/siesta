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
    has_many :comments
end
