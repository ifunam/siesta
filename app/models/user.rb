require 'digest/sha2'
class User < ActiveRecord::Base

  attr_accessor :current_passwd

  validates_presence_of     :login, :email, :passwd
  validates_uniqueness_of   :login, :email
  validates_length_of       :login, :within => 3..30
  validates_length_of       :email, :within => 7..100
  validates_length_of       :passwd, :within => 5..200, :allow_nil => true
  validates_confirmation_of :passwd
  validates_format_of       :email, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/
  validates_format_of       :login, :with =>  /\A[-a-z0-9\.]*\Z/

  belongs_to :userstatus
  has_one :person

  # Callbacks
  before_create :prepare_new_record
  after_validation_on_create :encrypt_password
  before_validation_on_update :verify_current_password
  class << self

    def authenticate?(login,password)
      @user = User.find_by_login(login)
      (!@user.nil? and @user.passwd == encrypt(password, @user.salt) and @user.is_confirmed?) ? true : false
    end

    def authenticate_by_token?(login,token)
      @user = User.find_by_login(login)
      (!@user.nil? and @user.token== token and @user.is_confirmed?) ? true : false
    end

    def encrypt(password, mysalt)
      Digest::SHA512.hexdigest(password + mysalt)
    end
  end

  def confirm
    change_userstatus(2)
    self.token = nil
    save(true)
  end

  def activate
    change_userstatus(3)
  end

  def approve
    change_userstatus(5)
  end

  def lock
    change_userstatus(4)
  end

  def reject
    change_userstatus(6)
  end

  def is_new?
    self.userstatus_id == 1 # 'Nuevo'
  end

  def is_confirmed?
    self.userstatus_id == 2 # 'Cuenta confirmada o Confimado'
  end

  def is_approved?
     self.userstatus_id == 5 # 'Aprobado'
  end

  def is_locked?
    self.userstatus_id == 4 # 'En suspensión'
  end

  def is_rejected?
    self.userstatus_id == 6 # 'Rechazado'
  end

  def is_in_history_file?
    self.userstatus_id >= 6 # Look for history file: 'No Aprobado', 'Egresado' 'Titulado', 'Baja'
  end

  def has_user_incharge?
    !self.user_incharge_id.nil?
  end

  def new_token
    self.token = token_string(10)
    self.token_expiry = 7.days.from_now
    save(true)
  end

  def destroy_token
    self.token = nil
    self.token_expiry = nil
    save(true)
  end

  protected
  def prepare_new_record
    # New userstatus and preparing the tokens for the account activation process
    # The salt is used to add a random factor to the plaintext. This might
    # make some cryptographic attacks more difficult.
    self.userstatus_id = 1

    self.token = token_string(10)
    self.token_expiry = 7.days.from_now
  end

  def encrypt_password
    if self.passwd != nil
      self.salt = get_salt
      plaintext = passwd
      self.passwd = User.encrypt(plaintext, self.salt)
      self.passwd_confirmation = nil
    end
  end

  def verify_current_password
    if !self.current_passwd.nil?
      if User.find(:first, :conditions => ["id = ?", self.id]).passwd != User.encrypt(self.current_passwd, self.salt)
        errors.add("current_passwd", "is not valid")
        return false
      end
      encrypt_password
    end
  end

  def change_userstatus(status)
    self.userstatus_id = status
    save(true)
  end

  def get_salt
    token_string(40)
  end

  def token_string(n)
    if n.to_i > 1
      s = ""
      char64 = (('a'..'z').collect + ('A'..'Z').collect + ('0'..'9').collect + ['.','/']).freeze
      n.times { s << char64[(Time.now.tv_usec * rand) % 64] }
      s
    end
  end

end
