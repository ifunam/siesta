class StudentProfile < User
  has_one :person, :foreign_key => :user_id
  has_one :address, :foreign_key => :user_id
  has_many :schoolings, :foreign_key => :user_id
  has_many :user_documents, :foreign_key => :user_id
  has_many :user_requests, :foreign_key => :user_id 

  def fullname
    self.person.fullname
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

  def phone
    self.address.phone
  end
  
  private
  def user_incharge
    most_recent_user_request.user_incharge.login
  end
  
  def most_recent_user_request
    self.user_requests.find(:first, :order => 'periods.startdate DESC', :include => [:period])
  end
end
