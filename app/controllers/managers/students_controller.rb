class Managers::StudentsController < Managers::ApplicationController

  respond_to :html, :only => [:index, :show]
  respond_to :jpg, :only => [:card_front, :card_back]
  def index
     @user_requests = UserRequest.all(:conditions => ["user_requests.period_id = 9 AND user_requests.requeststatus_id > 1 AND people.lastname1 ~* ?", '^' + (params[:char] || 'A') ], :order => 'periods.startdate DESC', :include => [:period, {:user => :person}]).paginate(:page => params[:page] || 1, :per_page => params[:per_page] || 10)
     respond_with(@user_requests)
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
end
