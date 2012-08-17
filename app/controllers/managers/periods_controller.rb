class Managers::PeriodsController < Managers::ApplicationController
  respond_to :html
  
  def index
    respond_with(@periods = Period.paginate(:page => params[:page] || 1, :per_page =>  params[:per_page] || 10))
  end

  def new
    respond_with(@period = Period.new)
  end
  
  def create
    respond_with(@period = Period.create(params[:period]), :status => :created, :location => managers_periods_path)
  end

  def edit
    respond_with(@period = Period.find(params[:id]))
  end
  
  def update
    @period = Period.find(params[:id])
    respond_with(@period.update_attributes(params[:period]), :status => :updated, :location => managers_periods_path)
  end

  def destroy
    @period = Period.find(params[:id])
    @period.destroy
    respond_with(@period, :status => :deleted, :location => managers_periods_path)
  end
end
