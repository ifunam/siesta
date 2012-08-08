class StatesController < ApplicationController
  respond_to :json, :html
  # respond_to :html

  def filter_by
    respond_with(@states = State.filter_by_country_id(params[:country_id]), :status => :ok) do |format|
      format.json { render :json => @states, :only => [:id, :name] }
      # format.html { render :action => 'select_form', :layout => false }
    end
  end
end
