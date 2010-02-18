class Notifier < ActionMailer::Base
  default :from => "no-reply-siesta@fisica.unam.mx"
  $subject_prefix = '[SIESTA] - '

  def new_password(user)
    send_mail_to(user, "Nueva contraseña")
  end

  def new_user(user)
    send_mail_to(user, "Información de nueva cuenta")
  end

  def student_notification(user)
    send_mail_to(user, "Su solicitud de Estudiante Asociado fue enviada")
  end

  def academic_notification(academic_email, user)
    @user = user 
    mail(:to => academic_email, :subject => $subject_prefix + 'Solicitud de Estudiante Asociado - IFUNAM') do |format|
      format.text
    end
  end

  def authorized_notification(user)
    send_mail_to(user, "Solicitud de Estudiante Asociado autorizada")
  end

  def unauthorized_notification(user)
    send_mail_to(user, "Solicitud de Estudiante Asociado no autorizada")
  end

  def new_local_user(login, password, fullname)
    @login = login
    @passwd = password
    @fullname = fullname
    mail(:to => 'javo@fisica.unam.mx', :subject => $subject_prefix + 'Nueva cuenta de Estudiante Asociado - IFUNAM') do |format|
        format.text
    end
  end

  private
  def send_mail_to(user, subject)
    @user = user 
    mail(:to => user.email, :subject => $subject_prefix + subject) do |format|
      format.text
    end
  end
end