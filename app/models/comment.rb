class Comment < ActiveRecord::Base
  validates_presence_of :user_id, :subject, :body
  validates_numericality_of :user_id, :greater_than => 0, :only_integer => true
  validates_numericality_of :id, :user_request_id, :parent_id, :allow_nil => true, :greater_than => 0, :only_integer => true

  belongs_to :user
  belongs_to :user_request
  belongs_to :parent, :class_name => 'Comment', :foreign_key => 'parent_id'

  acts_as_tree
end
