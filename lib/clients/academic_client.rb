class AcademicClient < ActiveResource::Base
  self.site = 'http://salva.fisica.unam.mx:8080/'
  self.element_name = "academic"

  # Fix It: Remove this method after of the UpdateRemoteAttributesInUserRequests migration
  def self.find_by_login(login)
     @attributes = self.get("show_by_login/#{login}")
     self.find(@attributes['user_id'])
  end
  
  def fullname
    @attributes['fullname']
  end

  def adscription_name
    @attributes['adscription']
  end

  def adscription_id
    @attributes['adscription_id']
  end
end
