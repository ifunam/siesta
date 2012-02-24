require 'yaml'
require 'rest_client'
module Aleph
  class User < ActiveResource::Base
    include ActiveModel::Serialization
    include ActiveModel::MassAssignmentSecurity
    aleph_config_path = File.join(Rails.root.to_s, 'config', 'aleph.yml')

    if File.exist? aleph_config_path
      config = YAML.load_file(aleph_config_path)
      self.site = [config['host'], config['port']].join(':')
      self.headers['X-Aleph-Token'] = config['auth_token']
    end

    def self.find(*arguments)
      obj = super *arguments
      obj.new_user = false
      obj
    end

    attr_accessor :new_user

    def id
      attributes['key'].to_s.strip if @new_user == false
    end

    def create
      resource = RestClient::Resource.new "#{self.class.site}/users.xml", :headers => self.class.headers
      resource.post :user => @attributes
      @new_user = false
    end

    def update
      resource = RestClient::Resource.new "#{self.class.site}/users/#{key}.xml", :headers => self.class.headers
      resource.put :user => @attributes
      resource
    end

    def attributes=(hash)
      sanitize_for_mass_assignment(hash).each do |attribute, value|
         send("#{attribute}=", value)
      end
    end
  end
end
