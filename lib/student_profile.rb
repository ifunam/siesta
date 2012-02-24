# encoding: utf-8
class StudentProfile < User
  has_one :person, :foreign_key => :user_id
  has_one :address, :foreign_key => :user_id
  has_many :schoolings, :foreign_key => :user_id
  has_many :user_documents, :foreign_key => :user_id
  has_many :user_requests, :foreign_key => :user_id 
  attr_accessible :login, :email

  def fullname
    self.person.fullname
  end

  def lastname
    self.person.lastname
  end

  def firstname
    self.person.firstname
  end
  def gender
    self.person.gender? ? 'Másculino' : 'Femenino'
  end
  
  def birthdate
    self.person.birthdate
  end
  
  def most_recent_schooling
    self.schoolings.find(:first, :select => 'degree_id', :order => 'startyear DESC')
  end

  def student_type
    most_recent_user_request.role.name
  end
  
  def period
    most_recent_user_request.period.name
  end

  def request_status
    most_recent_user_request.requeststatus.name
  end
  
  def academic_incharge
    most_recent_user_request.user_incharge.fullname
  end

  def department
    most_recent_user_request.user_incharge.adscription_name
  end

  def image_path
    image_path = Rails.root.to_s + "/public/images/comodin.jpg"
    if !person.nil? and !person.photo.nil? and File.exists? person.photo.path.to_s
      image_path = person.photo.path(:card)
    end
    image_path
  end

  def group 
    most_recent_user_request.adscription.group
  end

  def phone
    self.address.phone
  end
  
  # private
  def user_incharge
    most_recent_user_request.user_incharge.login
  end
  
  def most_recent_user_request
    self.user_requests.find(:first, :order => 'periods.startdate DESC', :include => [:period])
  end

  def code
    'E' + '0' * ( 5 - id.to_s.length ) + id.to_s
  end

  def attributes_to_hash
     { :key => code,
       :firstname => aleph_encode(firstname), :lastname => aleph_encode(lastname),
       :unit => aleph_encode(department), :academic_level => aleph_encode(most_recent_schooling.degree.name),
       :location => aleph_encode(address.location), :country => 'Mexico',
       :city => aleph_encode(address.city), :zipcode => address.zipcode.to_s,
       :email => email, :expiry_date => most_recent_user_request.period.enddate.to_s(:default).gsub(/-/,''),
       :phone => address.phone, :type => 'ES', :academic_responsible => aleph_encode(academic_incharge),
       :image => File.new(image_path) }
  end

  private
  def aleph_encode(string)
    string.to_s.force_encoding('utf-8').tr("áéíóúñÁÉÍÓÚÑ","aeiounAEIOUN").force_encoding('ascii').to_s
  end
end
