class User < ActiveRecord::Base
  devise :ldap_authenticatable

  validates :login, :uniqueness => true
  validates :email, :uniqueness => true

  has_one :person
  has_one :address
  has_many :user_documents
  has_many :user_requests
  accepts_nested_attributes_for :person, :address, :user_documents

  attr_accessible :person_attributes, :address_attributes, :user_documents_attributes

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
  search_methods :fullname_like, :period_id_equals, :requeststatus_id_equals, :role_id_equals,
                  :user_request_is_restamped, :user_request_is_official, :lastname_start_with

  def self.paginated_search(options={})
    search(options[:search]).paginate(:page => options[:page] || 1, :per_page =>  options[:per_page] || 10)
  end
end
