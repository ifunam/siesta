# encoding: utf-8
require 'RMagick'
require 'barby'
require 'barby/outputter/rmagick_outputter'
class Card
  include Magick
  attr_reader :code

  def initialize(user_id)
    @user = StudentProfile.find(user_id)
  end
  
  def front
    @image = Magick::Image.read(Rails.root.to_s+"/public/images/cards/front.jpg").first
    add_fullname_and_email!
    add_last_degree!
    add_student_type!
    add_department_and_user_incharge!
    @image.dissolve(user_image, 0.90, 1.0, 35, 20).to_blob
  end
  
  def back
    @image = Magick::Image.read(Rails.root.to_s+"/public/images/cards/back.jpg").first
    add_text!(Date.today.to_s, 280, 331, 24, BoldWeight)
    set_code
    add_text!(self.code, 800, 400, 24, BoldWeight)
    recent_period = Period.most_recent
    x = 265 
    y = 485 
    add_text!(recent_period.name + ' [*]', x, y, 24, BoldWeight)
    #x += 35 
    counter = 1 
    Period.find(:all, :conditions => ['startdate > ?', recent_period.enddate], :limit => 7, :order => 'startdate ASC').each do |period|
      add_text!(period.name + '[ ]', x+=125, y, 24, BoldWeight)
      counter += 1
      if counter == 4 
         counter = 0
         x = 140
         y += 50 
      end
    end
    @image.composite(barcode_image.resize(350,300), 650, 100, Magick::OverCompositeOp).to_blob
  end

  private
  def add_text!(string, x_offset, y_offset, font_size=24, font_weight=NormalWeight)
    text = Magick::Draw.new
    text.font_family = 'Arial'
    text.font_weight = font_weight
    text.pointsize = font_size
    text.stroke = 'transparent'
    text.fill = '#000000'
    text.gravity = Magick::NorthWestGravity
    text.annotate(@image, 0, 0, x_offset, y_offset, string)
  end
  
  def add_fullname_and_email!
    add_text!(@user.email, 35, 260)
    add_text!(@user.person.fullname, 290, 140, 28, BoldWeight)
  end
  
  def add_student_type!
    add_text!('Estudiante asociado: ', 290, 210, 24, BoldWeight)
    add_text!(@user.student_type, 540, 210)
  end
  
  def add_last_degree!
    add_text!('Nivel: ', 290, 180, 24, BoldWeight)
    add_text!(@user.most_recent_schooling.degree.name, 360, 180)    
  end  
  
  def add_department_and_user_incharge!
    add_text!('Departamento: ', 35, 330, 24, BoldWeight)
    add_text!(@user.department, 210, 330)
    add_text!('Responsable académico: ', 35, 360, 24, BoldWeight)
    add_text!(@user.academic_incharge, 330, 360)
  end

  def user_image
    image_path = Rails.root.to_s + "/public/images/comodin.jpg"
    image_path = @user.person.photo.path(:card) if !@user.person.nil? and File.exist? @user.person.photo.path
    pic = Magick::Image.read(image_path).first
    pic.resize(220,230).border(1,1,"#000000")
  end

  def set_code
    @code = 'E' + '0' * ( 5 - @user.id.to_s.length ) + @user.id.to_s
  end

  def barcode_image
    Barby::Code39.new(self.code).to_image
  end
end
