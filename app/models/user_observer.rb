class UserObserver < ActiveRecord::Observer
    def after_create(user)
	   Notifier.new_user(user).deliver
	end

   def after_update(user)
	   Notifier.new_password(user).deliver unless user.random_password.nil?	
   end
end