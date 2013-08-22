class StudentSerializer < ActiveModel::Serializer
  include ActionDispatch::Routing::UrlFor
  include Rails.application.routes.url_helpers
  include ApplicationHelper

  attributes :fullname,
             :email,
             :photo_url,
             :period

  def fullname
    object.user.person.fullname
  end

  def email
    object.user.email
  end

  def photo_url
    root_url + object.user.person.photo.url(:card)
  end

  def period
    object.period.name
  end
end
