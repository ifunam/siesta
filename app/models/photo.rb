require 'RMagick'
class Photo < ActiveRecord::Base
  include Magick

  validates_numericality_of :id, :allow_nil => true, :only_integer => true, :greater_than => 0
  validates_presence_of :user_id, :file, :filename, :content_type
  validates_numericality_of :user_id, :only_integer => true, :greater_than => 0
  validates_uniqueness_of :user_id
  
  belongs_to :user
  before_save :setup_image
  
  def setup_image
    unless self.file.nil?
      photo = Magick::Image.from_blob(self.file).first
      maxwidth = 200
      maxheight = 250
      aspectratio = maxwidth.to_f / maxheight.to_f
      imgwidth = photo.columns
      imgheight = photo.rows
      imgratio = imgwidth.to_f / imgheight.to_f
      imgratio > aspectratio ? scaleratio = maxwidth.to_f / imgwidth : scaleratio  = maxheight.to_f / imgheight
      photo.resize!(scaleratio)
      photo.crop!(CenterGravity, 110, 110)
      photo.format = 'JPG'
      self.file = photo.quantize(256, Magick::GRAYColorspace).to_blob
    end
 end
end
