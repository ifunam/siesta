class UserDocument < ActiveRecord::Base
  has_attached_file :file
  validates_attachment_size :file, :less_than => 10.megabytes
  validates_attachment_content_type :file, :content_type => ['image/jpeg', 'image/jpg', 'image/png', 'image/gif', 'application/pdf', 'application/postscript', 'application/x-pdf']

  attr_accessible :document_id, :file
  validates :document_id, :presence => true, :numericality => true
  belongs_to :user
  belongs_to :document
end
