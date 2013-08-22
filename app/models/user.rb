class User < ActiveRecord::Base
  devise :ldap_authenticatable, :rememberable, :authentication_keys => [:login]

  validates :email, :uniqueness => true

  has_one :person
  has_one :address
  has_many :schoolings
  has_many :user_documents
  has_many :user_requests

  accepts_nested_attributes_for :person, :address, :user_documents
  attr_accessible :login, :person_attributes, :address_attributes, :user_documents_attributes

  scope :firstname_like, lambda { |firstname| where(" users.id IN (#{Person.search(:firstname_like => firstname).select('user_id').to_sql}) ") }
  scope :lastname1_like, lambda { |lastname| where(" users.id IN (#{Person.search(:lastname1_like => lastname).select('user_id').to_sql}) ") }
  scope :lastname2_like, lambda { |lastname| where(" users.id IN (#{Person.search(:lastname2_like => lastname).select('user_id').to_sql}) ") }
  scope :fullname_like, lambda { |fullname| where(" users.id IN (#{Person.find_by_fullname(fullname).select('user_id').to_sql}) ") }
  scope :fullname_asc, joins(:person).order('people.lastname1 ASC, people.lastname2 ASC, people.firstname ASC')
  scope :student, where(:role => nil)
  scope :academic, where(:role => 'academic')
  scope :period_id_equals, lambda { |period_id| joins(:user_requests).where(["user_requests.period_id = ?", period_id] ) }
  scope :requeststatus_id_equals, lambda { |requeststatus_id| joins(:user_requests).where(["user_requests.requeststatus_id = ?", requeststatus_id] ) }
  scope :role_id_equals, lambda { |role_id| joins(:user_requests).where(["user_requests.role_id = ?", role_id] ) }
  scope :user_request_is_restamped, lambda { |is_restamped| joins(:user_requests).where(["user_requests.is_restamped = ?", is_restamped] ) }
  scope :user_request_is_official, lambda { |is_official| joins(:user_requests).where(["user_requests.is_official = ?", is_official] ) }
  scope :lastname_start_with, lambda { |char| joins(:person).where("people.lastname1 ~* ?", ('^' + char)) }

  unless Period.activated.nil?
  	scope :activated, period_id_equals(Period.activated.id).user_request_is_official(true)
  	scope :approved, period_id_equals(Period.activated.id).requeststatus_id_equals(3)
  else
 	scope :activated, where(:role => nil)
 	scope :approved, where(:role => nil)
  end
  scope :student_code, lambda { |code| where(:id => code.sub(/^(E|e)(0)+/,'').to_i) }

  search_methods :fullname_like, :period_id_equals, :requeststatus_id_equals, :role_id_equals,
                  :user_request_is_restamped, :user_request_is_official, :lastname_start_with,
                  :student_code, :firstname_like, :lastname1_like, :lastname2_like

  def self.paginated_search(options={})
    search(options[:search]).paginate(:page => options[:page] || 1, :per_page =>  options[:per_page] || 10)
  end

  def self.simple_search(options={})
    search(options[:search]).all
  end

  def self.find_profile(user_id)
    @user = self.find(user_id)
    @user.build_person_and_address unless @user.person_or_address? 
    @user
  end

  def login_or_email
    login || email
  end

  def person?
    !person.nil?
  end

  def address?
    !address.nil? 
  end

  def person_or_address?
    person? || address?
  end

  def schoolings?
    schoolings.count > 0
  end

  def user_documents?
    user_documents.count > 0
  end

  def build_person_and_address
    build_person unless person?
    build_address unless address?
  end
end
