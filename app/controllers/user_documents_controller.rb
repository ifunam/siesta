class UserDocumentsController < SharedController
  # GET /categories
  # GET /categories.xml
  def initialize
    @model = UserDocument
    super
  end
end
