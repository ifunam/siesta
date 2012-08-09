# Fix It: Rewrite this class
class UserRequestRequirement < User
  has_one :person, :foreign_key => :user_id
  has_many :addresses, :foreign_key => :user_id
  has_many :schoolings, :foreign_key => :user_id
  has_many :user_documents, :foreign_key => :user_id
  has_many :user_requests, :foreign_key => :user_id

  def has_person?
    !self.person.nil?
  end

  def has_address?
    !Address.find(:first, :conditions => ['user_id = ? AND addresstype_id = 1', self.id]).nil?
  end

  def has_schooling?
    !Schooling.find(:first, :conditions => ["schoolings.user_id = ?", self.id]).nil?
  end

  def has_user_documents?
    self.user_documents.size >= 1
  end

  def has_user_request?
    !UserRequest.find(:first, :conditions => [ 'user_requests.user_id = ? AND user_requests.period_id = ?', self.id, Period.most_recent.id]).nil?
  end

  def requirements
    [
     [:person, :edit_profile, has_person?],
     [:address, :edit_profile, has_address?],
     [:schoolings, :schoolings, has_schooling?],
     [:user_documents, :user_documents, has_user_documents?],
     [:user_requests, :user_requests, has_user_request?]
    ]
  end

  def section(key)
    self.send(key)
  end

  def has_filled_requirements?
    status = true
    self.requirements.each { |h| status = h[:filled] if  h[:filled] == false }
    return status
  end

  def current_request
    UserRequest.find(:first, :conditions => [ 'user_requests.user_id = ? AND user_requests.period_id = ?', self.id, Period.most_recent.id])
  end

  def is_current_request_saved?
    self.current_request.requeststatus_id  == 1
  end

  def is_current_request_sent?
    self.current_request.requeststatus_id  == 2
  end

  def current_request_status
    self.current_request.requeststatus.name
  end

  def all_requests
    # todo: You should use periods.startdate instead applicant_requests.period_id at order option
    UserRequest.find(:all, :conditions => [ 'user_requests.user_id = ?', self.id], :include => [:period], :order => 'periods.startdate DESC')
  end
end
