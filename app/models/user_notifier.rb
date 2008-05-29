require 'yaml'
class UserNotifier < ActionMailer::Base
  private
  def setup(options)
    smtp = YAML.load(File.read("#{RAILS_ROOT}/config/mail.yml"))
    domain = smtp['settings'][:domain].to_s
    @recipients = options[:recipients] || "noreply@#{domain}"
    @from = options[:from] || "noreply@#{domain}"
    @subject = "[SIESTA] "
    @subject << options[:subject] unless options[:subject].nil?
    @body = options[:body] || {}
    @headers = options[:headers] || {}
    @sent_on  = Time.now
  end

  public
  def new_notification(user,url)
    setup({:recipients => user.email, :subject => 'Su cuenta ha sido creada, por favor activela...', :body => { :user => user, :url => url} })
  end

  def activation(user,url)
    setup({:recipients => user.email, :subject => 'Su cuenta ha sido activada',  :body => { :user => user, :url => url} })
  end

  def password_recovery(user,url)
    setup({:recipients => user.email, :subject => 'Información para cambiar la contraseña de su cuenta', :body => { :user => user, :url => url}})
  end

  def user_request(user)
    setup({:recipients => [user.email, $email_admin ], :subject => 'Solicitud de Estudiante Asociado - IFUNAM', :body => { :fullname => user.person.fullname } })
  end
end
