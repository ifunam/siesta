# UserProfile.find_by_login('john') or UserProfile.find(id)
class UserProfile < User
  has_one :person, :foreign_key => :user_id
  has_many :addresses, :foreign_key => :user_id
  has_many :schoolings, :foreign_key => :user_id
  has_many :user_documents, :foreign_key => :user_id
  has_many :user_requests, :foreign_key => :user_id 
  has_one :photo, :foreign_key => :user_id

  def address
    self.addresses.find(:conditions => 'addresstype_id = 1')
  end

  def most_recent_schooling_degree
    self.schoolings.find(:first, :select => 'degree_id', :order => 'startyear DESC')
  end

  def student_type
    self.user_requests.find(:first, :order => 'periods.startdate DESC', :include => [:period]).role.name
  end

  def academic_incharge
    @academic = AcademicClient.find_by_login(user_incharge)
    @academic.fullname unless @academic.nil?
  end

  def department
    @academic = AcademicClient.find_by_login(user_incharge)
    @academic.adscription_name unless @academic.nil?
  end

  private
  def user_incharge
    self.user_requests.find(:first, :order => 'periods.startdate DESC', :include => [:period]).user_incharge.login
  end
end