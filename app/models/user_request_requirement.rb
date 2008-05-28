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
    !Address.find(:first, :conditions => "user_id = #{self.id} AND addresstype_id = 1").nil?
  end

  def has_schooling?
    !Schooling.find(:first, :conditions => "schoolings.user_id = #{self.id}").nil?
  end

  def has_user_documents?
    self.user_documents.size == 2
  end

  def has_user_request?
    !UserRequest.find(:first, :conditions => "user_requests.user_id = #{self.id} AND user_requests.period_id = #{Period.get_most_recent.id}").nil?
  end

  def requirements
    [
     [:people, 'has_person?', false],
     [:addresses, 'has_address?', true],
     [:schoolings, 'has_schooling?', true],
     [:user_documents, 'has_user_documents?', true],
     [:user_requests, 'has_user_request?', true],
    ].collect do  |a|
        controller = a[0].to_s
        controller = 'address' if controller == 'addresses'
        controller = 'person' if controller == 'people'
        { :controller => controller, :filled => self.send(a[1]), :is_collection => a[2],
         :records => self.section(a[2] == true ? a[0] : Inflector.singularize(a[0]))
      }
    end
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
    UserRequest.find(:first, :conditions => "user_requests.user_id = #{self.id} AND user_requests.period_id = #{Period.get_most_recent.id}")
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
    UserRequest.find(:all, :conditions => "user_requests.user_id = #{self.id}", :order => 'user_requests.period_id DESC')
  end
end
