class AdscriptionClient < ActiveResource::Base
  self.site = 'attributesttp://salva.fisica.unam.mx/'
  self.element_name = "adscription"
  
  def users
    i = 0
    AdscriptionClient.get("users/#{self.id}").collect { |attributes|
      user = import_remote_user(attributes)
      [fullname_remote_user(attributes), user.id] 
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

  def import_remote_user(attributes)
    unless User.exists?(:login => attributes['login'])
      user = User.new(:login => attributes['login'], :email => attributes['email'], :password => 'qw12..', :password_confirmation => 'qw12..')
      user.save!
    else
      User.find_by_login(attributes['login'])
    end
  end 
end