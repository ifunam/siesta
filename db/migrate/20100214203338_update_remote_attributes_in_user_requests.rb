class UpdateRemoteAttributesInUserRequests < ActiveRecord::Migration
  def self.up
    UserRequest.all.each do |record|
      unless record.local_user_incharge.nil?
        puts "Updating remote_user_incharge_id for #{record.local_user_incharge.login}"
        @remote_user = AcademicClient.find_by_login(record.local_user_incharge.login)
        unless @remote_user.nil?
          record.remote_user_incharge_id = @remote_user.id
          record.remote_adscription_id = @remote_user.adscription_id
          record.save
        end
      end
    end
  end

  def self.down
    UserRequest.all.each do |record|
      @remote_user = AcademicClient.find_by_login(record.local_user_incharge.login)
      record.remote_user_incharge_id = nil
      record.remote_adscription_id = nil
      record.save
    end
    
  end
end
