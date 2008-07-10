class Academic::PhotosController < ApplicationController
  layout 'academic'
  
  def show
    @photo = Photo.find_by_user_id(params[:id])
    respond_to  do |format|
      format.jpg {
        unless @photo.nil?
          send_data @photo.file, :filename => @photo.filename, :type => @photo.content_type, :disposition => 'inline'
        else
          send_file RAILS_ROOT + "/public/images/comodin.jpg", :type => 'image/jpg', :disposition => 'inline'
        end
      }
    end
  end
end