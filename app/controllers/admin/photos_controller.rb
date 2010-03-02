class Admin::PhotosController < Academic::ApplicationController 
  layout 'academic'
  respond_to :html
  def edit
    @person = Person.find(params[:id])
    respond_with(@person)
  end
  
  def update
    @person = Person.find(params[:id])
    if @person.update_attributes(params[:person])
      respond_with(@person, :status => :updated, :location => admin_student_path(:id => @person.user_id))
    else
      respond_with(@person, :status => :unprocessable_entity, :location => edit_admin_photo_path(:id => @person.user_id))
    end
  end
end