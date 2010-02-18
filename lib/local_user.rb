require 'bcrypt'
require 'iconv'
# Fix It: Add hoc code to generate users for local unix system using active record syntax.
class LocalUser
  include BCrypt
  include ActiveModel::Validations
  extend  ActiveModel::Translation
  
  validates_presence_of :username, :passwd, :passwd_confirmation
  attr_accessor :username, :passwd, :passwd_confirmation, :gecos

  PasswdFile = File.join(Rails.root, 'db/passwd')

  def initialize(attributes = {})    
    attributes.merge!(:passwd => encrypt(attributes[:passwd])) if attributes.has_key? :passwd
    attributes.each { |name, value| send("#{name}=", value) }
  end
  
  def encrypt(string, method=:create)
      BCrypt::Password.send method, string
  end

  def valid?
    super
    self.errors.add :username, 'user exists' if LocalUser.exist?(:username => username)
    self.errors.add :passwd, "password does not match" if encrypt(passwd, :new) != passwd_confirmation
    !(self.errors.size > 0)
  end

  def save
    if valid?
      save_new_record
      true
    else
      false
    end
  end

  def self.exist?(attributes)
    fields = attributes.keys.freeze
    self.all.each do |record|
      return true if attributes == extract_attributes(record, fields.dup)
    end
    return false
  end

  def self.gecos_like(string)
    words = self.sanitize(string).split
    self.all.collect { |record|
      record if (record[:gecos].downcase.split & words).size > 0
    }.compact
  end
  
  private
  def self.all
    File.read(PasswdFile).collect do |line|
      values = line.split(':')
      { :username => values[0], :uid => [1], :gid => [2], :gecos => values[4] }
    end
  end

  def self.sanitize(string)
    Iconv.iconv("ASCII//IGNORE//TRANSLIT", "UTF-8", string).to_s.downcase.gsub(/\'/,'').gsub(/~/,'').gsub(/\n/,'')
  end

  def self.extract_attributes(record, keys)
    record.values_at(*keys).inject({}) {|hash,value| hash[keys.shift] = value; hash }
  end

  def set_gecos(string)
      LocalUser.sanitize(string).split.collect { |word| word.capitalize }.join(' ')
  end
  
  def save_new_record
    File.open(PasswdFile, "a+") do |file|
      file.puts [username, 1000, 1000, passwd, set_gecos(gecos), "/home/#{username}", "/bin/bash"].join(':')
    end
  end
end
