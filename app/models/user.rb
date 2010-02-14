class User < ActiveRecord::Base
  attr_reader :random_password

  acts_as_authentic do |c|
    c.logged_in_timeout = 120.minutes
  end

  has_one :person
  has_one :address
  has_many :user_documents
  accepts_nested_attributes_for :person, :address, :user_documents

  def randomize_password
    @random_password = SecureRandom.hex(3)
    self.password = self.password_confirmation = @random_password
    save(:validate => true)
  end
end
