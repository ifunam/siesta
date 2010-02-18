class Admin::PhotosController < Academic::ApplicationController 
  layout 'academic'

  def edit
    @person = Person.find(params[:id])
  end
  
  def update
    @person = Person.find(params[:id])
    if @person.update_attributes(params[:person])
      redirect_to admin_student_path(:id => @person.user_id)
    else
      redirect_to edit_admin_photo_path(:id => @person.user_id)
    end
  end
end