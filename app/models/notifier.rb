class Notifier < ActionMailer::Base
	default :from => "no-reply-siesta@fisica.unam.mx"
	$subject_prefix = '[SIESTA] - '

	def new_password(user)
		send_mail_to(user, "New password")
	end

	def new_user(user)
		send_mail_to(user, "New account information")
	end

	private
	def send_mail_to(user, subject)
		@user = user 
		mail(:to => user.email, :subject => $subject_prefix + subject) do |format|
		   format.text
		end
	end
end