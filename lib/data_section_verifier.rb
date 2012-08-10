# Fix It: Rewrite this class using State Machine
module DataSection
  class Resource
    attr_reader :title, :url
    def initialize(title, url)
      @title = title
      @url = url
    end

    def url
      Rails.application.routes_url_helpers.send @url
    end
  end

  class Verifier
    attr_reader :missed, :filled

    def self.find_by_user_id(user_id)
      new(user_id)
    end

    def initialize(user_id)
      @user = User.find(user_id)
      @missed = []
      @filled = []
    end

    def missed?
      verify
      missed.count > 0
    end

    private
    def verify
      (@user.person? and @user.address?) ? @filled.push(profile_resource) : @missed.push(profile_resource)
      @user.schoolings? ? @filled.push(schooling_resource) : @missed.push(schooling_resource)
      @user.user_documents? ? @filled.push(user_document_resource) : @missed.push(user_document_resource)
    end

    def profile_resource
      DataSection::Resource.new(:profile, :profile_path)
    end

    def schooling_resource
      DataSection::Resource.new(:schoolings, :schoolings_path)
    end

    def user_document_resource
      DataSection::Resource.new(:user_documents, :user_documents_path)
    end
  end
end
