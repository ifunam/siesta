class User < ActiveRecord::Base
  attr_reader :random_password

  acts_as_authentic do |c|
	c.logged_in_timeout = 120.minutes
  end

  def randomize_password
	@random_password = SecureRandom.hex(3)
	self.password = self.password_confirmation = @random_password
	save(:validate => true)
  end
end
