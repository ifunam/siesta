class PhotosController < ApplicationController
  def show
    @record = Photo.find_by_user_id(params[:id])
    respond_to  do |format|
      format.jpg {
        unless @record.nil?
          send_data @record.file, :filename => @record.filename, :type => @record.content_type, :disposition => 'inline'
        else
          send_file RAILS_ROOT + "/public/images/comodin.jpg", :type => 'image/jpg', :disposition => 'inline'
       end
      }
    end
  end
end
