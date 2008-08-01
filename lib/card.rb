require 'RMagick'
require 'barby'
require 'barby/outputter/rmagick_outputter'
class Card
  include Magick
  attr_reader :code

  def initialize(user_id)
    @user_id = user_id
  end
  
  def front
    @image = Magick::Image.read(RAILS_ROOT+"/public/images/cards/front.jpg").first
    add_fullname_and_email!
    # add_identifications!
    add_last_degree!
    add_student_type!
    add_department_and_user_incharge!
    #.composite(pic, 35, 20, Magick::OverCompositeOp)
    @image.dissolve(user_image, 0.90, 1.0, 35, 20).to_blob
  end
  
  def back
    @image = Magick::Image.read(RAILS_ROOT+"/public/images/cards/back.jpg").first
    add_text!(Date.today.to_s, 280, 331, 20, BoldWeight)
    set_code
    add_text!(self.code, 800, 400, 20, BoldWeight)
    recent_period = Period.most_recent
    add_text!(recent_period.name + ' [*]', 130, 395, 20, BoldWeight)
    x = 150
    Period.find(:all, :conditions => ['startdate > ?', recent_period.enddate], :limit => 3, :order => 'startdate ASC').each do |period|
      add_text!(period.name + '[ ]', x+=105, 395, 20, BoldWeight)
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
    @user = User.find(self.user_id)
    add_text!(@user.email, 35, 260)
    add_text!(@user.person.fullname, 290, 140, 28, BoldWeight)
  end
  
  def add_identifications!
    add_text!('RFC:', 290, 180, 24, BoldWeight)
    add_text!('JURJ770317C32', 365, 180)
    add_text!('CURP: ', 290, 210, 24, BoldWeight)
    add_text!('JURJ770317HCSRBS08', 365 , 210)
  end
  
  def add_last_degree!
    schooling = Schooling.find_by_user_id(self.user_id, :order => 'startyear DESC')
    add_text!('Nivel: ', 35, 300, 24, BoldWeight)
    add_text!(schooling.degree.name, 100, 300)    
  end  
  
  def add_student_type!
    user_request = UserRequest.find_by_user_id(self.user_id, :order => 'updated_at DESC')
    add_text!('Estudiante asociado: ', 35, 330, 24, BoldWeight)
    add_text!(user_request.role.name, 280, 330)
  end
  
  def add_department_and_user_incharge!
    user_request = UserRequest.find_by_user_id(self.user_id, :order => 'updated_at DESC')
    academic = AcademicClient.find_by_login(user_request.user_incharge.login)
    add_text!('Departamento: ', 35, 360, 24, BoldWeight)
    add_text!(academic.department, 210, 360)
    add_text!('Responsable académico: ', 35, 390, 24, BoldWeight)
    add_text!(academic.name, 330, 390)
  end

  def user_image
    pic = Magick::Image.read(RAILS_ROOT+"/public/images/comodin.jpg").first
    record = Photo.find_by_user_id(@user_id)
    pic = Magick::Image.from_blob(StringIO.new(record.file).read).first unless record.nil?
    pic.resize(220,230).border(1,1,"#000000")
  end

  def set_code
    @code = 'E' + '0' * ( 5 - @user_id.to_s.length ) + @user_id.to_s
  end

  def barcode_image
    Barby::Code39.new(self.code).to_image
  end
end
