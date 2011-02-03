class Managers::PhotosController < Managers::ApplicationController
  layout 'admin'
  respond_to :html
  def edit
    respond_with(@person =  Person.find(params[:id]))
  end

  def update
    @person = Person.find(params[:id])
    if @person.update_attributes(params[:person])
      respond_with(@person, :status => :updated, :location => managers_student_path(:id => @person.user_id))
    else
      respond_with(@person, :status => :unprocessable_entity, :location => edit_managers_photo_path(:id => @person.user_id))
    end
  end
end
