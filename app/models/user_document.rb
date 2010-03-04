class UserDocument < ActiveRecord::Base
  has_attached_file :file
  validates :document_id, :presence => true, :numericality => true
  
  #validates_attachment_content_type :file, :content_type => ['image/jpeg', 'image/jpg', 'image/png', 'image/gif', 'application/pdf', 'application/postscript']
  validates_attachment_size :file, :max_size => 1..2048
  belongs_to :user
  belongs_to :document
end
