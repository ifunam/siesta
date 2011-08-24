class Librarians::StudentsController < Librarians::ApplicationController    
  layout 'librarian'
  respond_to :html, :js
  
  def index
    respond_with(@users = User.student.activated.fullname_asc.paginated_search(params))
  end

end