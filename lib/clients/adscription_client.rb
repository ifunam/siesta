class AdscriptionClient < ActiveResource::Base
  self.site = 'attributesttp://salva.fisica.unam.mx/'
  self.element_name = "adscription"
  
  def users
    i = 0
    AdscriptionClient.get("users/#{self.id}").collect { |attributes|
      [fullname_remote_user(attributes), attributes['id']] 
    }.compact.sort {|a, b| a[i] <=> b[i]}
  end 
  
  def id
    @attributes['id']
  end
  
  def name
    @attributes['name']
  end

  def fullname_remote_user(attributes)
    %w(lastname1 lastname2 firstname).collect {|k| attributes['person'][k] }.join(' ')
  end
end