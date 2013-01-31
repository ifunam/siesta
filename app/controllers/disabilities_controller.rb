class DisabilitiesController < ApplicationController
  respond_to :html
  def index
    respond_with(@collection = Disability.where(:disability_type_id => params[:disability_type_id]).all.collect {|record| [record.name, record.id]}, :layout => false)
  end
end
