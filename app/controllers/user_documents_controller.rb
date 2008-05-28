class UserDocumentsController < SharedController
  # GET /categories
  # GET /categories.xml
  def initialize
    @model = UserDocument
    super
    @columns = %w( document )
  end
end
