# encoding: utf-8
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

  def academic_notification(user_request)
    @user_request = user_request
    mail(:to => @user_request.user_incharge.email, :subject => $subject_prefix + 'Solicitud de Estudiante Asociado - IFUNAM') do |format|
      format.text
    end
  end

  def authorized_notification(user_request)
    subject = 'Solicitud de Estudiante Asociado autorizada'
    @user_request = user_request
    filename = 'ReglasOperacionEstudiantesAsociadosIFUNAMAgosto2010.pdf'
    mail(:to => @user_request.user.email, :subject => $subject_prefix + subject) do |format|
      format.text
      attachments[filename] = File.read(Rails.root.to_s + "/app/views/notifier/#{filename}")  
    end
  end
  
  def authorized_notification_academic(user_request)
    subject = 'Solicitud de Estudiante Asociado autorizada'
    @user_request = user_request
    filename = 'ReglasOperacionEstudiantesAsociadosIFUNAMAgosto2010.pdf'
    mail(:to => @user_request.user_incharge.email, :subject => $subject_prefix + subject) do |format|
      format.text
      attachments[filename] = File.read(Rails.root.to_s + "/app/views/notifier/#{filename}")  
    end
  end

  def authorized_notification_academic_coordination(user_request)
    subject = 'Solicitud de autorización de Estudiante Asociado'
    @user_request = user_request
    mail(:to => 'cd-if@fisica.unam.mx', :subject => $subject_prefix + subject) do |format|
      format.text
    end
  end

  def authorization_from_academic_coordination_to_student(user_request)
    subject = 'Solicitud autorizada por la Coordinación Docente'
    @user_request = user_request
    mail(:to => @user_request.user.email, :subject => $subject_prefix + subject) do |format|
      format.text
    end
  end

  def authorization_from_academic_coordination_to_academic(user_request)
    subject = 'Solicitud autorizada por la Coordinación Docente'
    @user_request = user_request
    mail(:to => @user_request.user_incharge.email, :subject => $subject_prefix + subject) do |format|
      format.text
    end
  end


  def unauthorized_notification(user)
    subject = 'Solicitud de Estudiante Asociado no autorizada'
    @user = user
    mail(:to => user.email, :subject => $subject_prefix + subject) do |format|
      format.text
    end
  end

  def unauthorized_notification_academic(user, user_incharge)
    subject = 'Solicitud de Estudiante Asociado no autorizada'
    @user = user
    mail(:to => user_incharge.email, :subject => $subject_prefix + subject) do |format|
      format.text
    end
  end

  def new_local_user(login, password, fullname, group)
    @login = login
    @passwd = password
    @fullname = fullname
    @group = group 
    mail(:to => 'vic@fisica.unam.mx', :subject => $subject_prefix + 'Nueva cuenta de Estudiante Asociado - IFUNAM') do |format|
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
