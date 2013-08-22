class Public::StudentsController < ActionController::Base
  layout 'public'

  def index
    @academic = AcademicClient.find_by_login(params[:login])
    @collection = UserRequest.find_by_academic_login(params[:login])
    respond_to do |format|
      format.html
      format.json {
        unless request.remote_ip.to_s.match(/132.248.(209|7).\d+/).nil?
          render :json => @collection, :each_serializer => StudentSerializer 
        else
          render :text => 'Not Found', :status => '404'
        end
      }
    end
  end
end
