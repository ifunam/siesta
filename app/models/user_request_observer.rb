class UserRequestObserver < ActiveRecord::Observer
  def after_update(user_request)
    case user_request.requeststatus_id
    when 2
      Notifier.student_notification(user_request.user).deliver
      Notifier.academic_notification(user_request.user_incharge.email, user_request.user).deliver
    when 3
      Notifier.authorized_notification(user_request.user).deliver
    when 4    
      Notifier.unauthorized_notification(user_request.user).deliver
    end
  end
end