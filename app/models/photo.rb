class Photo < ActiveRecord::Base
  validates_numericality_of :id, :allow_nil => true, :only_integer => true, :greater_than => 0
  validates_presence_of :user_id, :file, :filename, :content_type
  validates_numericality_of :user_id, :only_integer => true, :greater_than => 0
  validates_uniqueness_of :user_id
  
  belongs_to :user
end
