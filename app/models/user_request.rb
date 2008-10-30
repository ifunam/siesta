class UserRequest < ActiveRecord::Base
    validates_presence_of  :user_id, :period_id, :role_id, :user_incharge_id
    validates_numericality_of :period_id, :role_id, :user_incharge_id, :greater_than => 0, :only_integer => true
    validates_numericality_of :id, :user_id, :allow_nil => true, :greater_than => 0, :only_integer => true
    validates_uniqueness_of :period_id, :scope => [:user_id]
    validates_inclusion_of :is_restamped, :in => [true, false]
    validates_inclusion_of :is_official, :in => [true, false]
    
    belongs_to :user, :class_name => "User", :foreign_key => "user_id"
    belongs_to :period
    belongs_to :role
    belongs_to :requeststatus
    belongs_to :user_incharge, :class_name => "User", :foreign_key => "user_incharge_id"

    has_many :comments
    
    after_save :set_user_incharge
    after_destroy :unset_user_incharge

    def self.search_with_paginate(options, page=1, per_page=10)
      options.keys.each { |k| options.delete k if options[k].nil? or options[k].to_s.strip.empty? }
      paginate(:all, :conditions => options, 
               :select => 'user_requests.*',
               :joins => "LEFT JOIN users ON user_requests.user_id = users.id LEFT JOIN people ON users.id = people.user_id", 
               :order => 'people.lastname1 ASC, people.lastname2 ASC, people.firstname ASC', 
               :page => page, :per_page => per_page)
    end

    def self.search(options={})
        default_options = { :select => 'user_requests.*',
                            :joins => "LEFT JOIN users ON user_requests.user_id = users.id LEFT JOIN people ON users.id = people.user_id", 
                            :order => 'people.lastname1 ASC, people.lastname2 ASC, people.firstname ASC'
                          }
        all(default_options.merge(options))
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
