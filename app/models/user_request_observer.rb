require 'clients/aleph_client'
class UserRequestObserver < ActiveRecord::Observer
  def after_update(user_request)
    case user_request.requeststatus_id
    when 2
      Notifier.student_notification(user_request.user).deliver
      Notifier.academic_notification(user_request).deliver
    when 3
      if user_request.is_official?
        Notifier.authorization_from_academic_coordination_to_student(user_request).deliver
        Notifier.authorization_from_academic_coordination_to_academic(user_request).deliver
        @user = StudentProfile.find(user_request.user.id)
        # @aleph = nil
        # begin
        #   @aleph = Aleph::User.find(@user.code)
        # rescue => e
        # end
        # if @aleph.nil?
        #   Aleph::User.create(@user.attributes_to_hash)
        # else
        #   @aleph.attributes = @user.attributes_to_hash
        #   @aleph.update
        # end
      else
        Notifier.authorized_notification(user_request).deliver
        Notifier.authorized_notification_academic(user_request).deliver
        Notifier.authorized_notification_academic_coordination(user_request).deliver
      end
    when 4    
      Notifier.unauthorized_notification(user_request.user).deliver
      Notifier.unauthorized_notification_academic(user_request.user, user_request.user_incharge).deliver
    end
  end
end
