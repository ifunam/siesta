class AdscriptionClient < ActiveResource::Base
  self.site = 'https://salva.fisica.unam.mx/api'
  self.element_name = "adscription"
  
  def users
    i = 0
    AdscriptionClient.get("#{self.id}/users").collect { |attributes|
      [attributes['fullname'], attributes['id']]
    }.compact.sort {|a, b| a[i] <=> b[i]}
  end 
  
  def id
    @attributes['id']
  end
  
  def name
    @attributes['name']
  end
  
  def group
    @attributes['abbrev']
  end

end
