class EventObserver < ActiveRecord::Observer
  def after_save(event)
    if event.user_request.want_office_cubicle?
      Notifier.office_cubicle_notification(event).deliver
    end
  end
end
