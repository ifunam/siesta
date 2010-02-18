require 'rmagick'
class Person < ActiveRecord::Base
  include Magick
  validates_numericality_of :id, :allow_nil => true, :only_integer => true, :greater_than => 0
  validates_presence_of :firstname, :lastname1, :birthdate, :country_id, :city
  validates_numericality_of :country_id, :greater_than => 0, :only_integer => true
  validates_numericality_of :state_id, :user_id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_inclusion_of :gender, :in => [true, false]
  validates_uniqueness_of :user_id

  has_attached_file :photo, :styles => { :medium => "150x150>", :thumb => "50x50>", :normal => "170x170", :card => '100x100' }  
  #  validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/jpg', 'image/png', 'image/gif', 'application/pdf', 'application/postscript']
  #  validates_attachment_size :photo, :max_size => 1..2048

  belongs_to :user
  belongs_to :country
  belongs_to :state

  def fullname
    [lastname1.strip, (lastname2 != nil ? lastname2.strip : nil), firstname].compact.join(' ')
  end

  def fullname_firstname
    [firstname, lastname1.strip, (lastname2 != nil ? lastname2.strip : nil)].compact.join(' ')
  end
  
  def placeofbirth
    [city.name,  state.name, country.name].compact.join(', ')
  end

  def build_card_image
    unless self.photo.nil?
      if File.exist? self.photo.path
        pic = Magick::Image.read(self.photo.path).first
        maxwidth = 200
        maxheight = 250
        aspectratio = maxwidth.to_f / maxheight.to_f
        imgwidth = pic.columns
        imgheight = pic.rows
        imgratio = imgwidth.to_f / imgheight.to_f
        imgratio > aspectratio ? scaleratio = maxwidth.to_f / imgwidth : scaleratio  = maxheight.to_f / imgheight
        pic.resize!(scaleratio)
        pic.crop!(CenterGravity, 110, 110)
        pic.format = 'JPG'
        card_dir = File.dirname(self.photo.path).sub(/original/, 'card')
        Dir.mkdir card_dir unless File.exist? card_dir
        card_path = self.photo.path.sub(/original/, 'card')
        pic.quantize(256, Magick::GRAYColorspace).write card_path
      end
    end
  end
end
