class UserDocument < ActiveRecord::Base
  validates_presence_of :file, :content_type, :filename
  belongs_to :user
  belongs_to :document
end
