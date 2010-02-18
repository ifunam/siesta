class Schooling < ActiveRecord::Base
  has_attached_file :file
  #validates_attachment_content_type :file, :content_type => ['image/jpeg', 'image/png', 'image/gif', 'application/pdf', 'application/postscript']
  #validates_attachment_size :file, :max_size => 1..2048

  validates_presence_of :degree_id, :career, :school, :institution, :average, :credits, :startyear
  validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of :average #, :greater_than => 5.9, :less_than_or_equal_to => 10
  validates_numericality_of :credits #,  :greater_than => 0, :less_than_or_equal_to => 100, :only_integer => true
  validates_numericality_of :startyear, :greater_than => (Date.today.year.to_i - 50), :less_than_or_equal_to => Date.today.year.to_i, :only_integer => true
  validates_numericality_of :endyear, :greater_than => (Date.today.year.to_i - 50), :only_integer => true, :allow_nil => true

  belongs_to :user
  belongs_to :degree
end
