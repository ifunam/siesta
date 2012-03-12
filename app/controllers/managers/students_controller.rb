# encoding: utf-8
require Rails.root.to_s + '/lib/reporter'
class Managers::StudentsController < Managers::ApplicationController
  include ApplicationHelper
  respond_to :html, :js, :csv, :xls

  def index
    respond_with(@users = User.student.fullname_asc.paginated_search(params))
  end

  def search
    respond_with(@users = StudentProfile.student.fullname_asc.simple_search(params)) do |format|
      format.js
      format.csv do
        headers["Content-Type"] = 'text/csv'
        headers['Content-Disposition'] = "attachment; filename=\"search_report_#{Time.now.strftime("%Y%m%d%H%m")}.csv\""
        render :action => 'search.csv', :layout => false
      end
      format.xls do
        @report = Siesta::Reporter.new(@users, params[:search])
        @report.build
        send_file(@report.file_path, :type => "application/vnd.ms-excel", :disposition => 'attachment')
      end
    end
  end

  def show
    @student = StudentProfile.find(params[:id])
    @student.person.build_card_image
    respond_with(@student)
  end

  def card_front
    @card = Card.new(params[:id])
    respond_to do |format|
      format.jpg do
        send_data @card.front, :filename => "front_studentid.jpg", :type => 'image/jpeg', :disposition => 'attachment'  
      end
    end
  end

  def card_back
    @card = Card.new(params[:id])
    respond_to do |format|
      format.jpg do
        send_data @card.back, :filename => "back_studentid.jpg", :type => 'image/jpeg', :disposition => 'attachment'  
      end
    end
  end

  def authorize
    @user_request = UserRequest.find(params[:id])
    @user_request.update_attribute(:is_official,true)
    respond_with(@user_request)
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    respond_with(@user, :status => :deleted, :location => managers_users_path)
  end
end
