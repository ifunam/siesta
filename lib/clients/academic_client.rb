class AcademicClient < ActiveResource::Base
  self.site = 'https://salva.fisica.unam.mx/api'
  self.element_name = "user"

  # Fix It: Remove this method after of the UpdateRemoteAttributesInUserRequests migration
  def self.find_by_login(login)
     @attributes = self.get("find_by_login/#{login}")
     self.find(@attributes['id'])
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
