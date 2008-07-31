require 'barby'
class Admin::CardsController < ApplicationController
  layout 'academic'

  def show
  end
  
  def new
    @record = Photo.new
    @record.user_id ||= params[:id]
    respond_to do |format|
      format.js { render :action => 'new.rjs' }
      format.html { render :action => 'new'}
      format.xml  { render :xml => @record }
    end
  end
  
  def create
    @record = Photo.new(params[:photo])
    @record.moduser_id = session[:user_id]
    self.set_file(@record, :photo) 
    respond_to do |format|
      if @record.save
        format.js { responds_to_parent { render :action => 'create.rjs'} }
        format.html { redirect_to :action => :index }
        format.xml  { render :xml => @record, :status => :created, :location => @record }
      else
        format.js { responds_to_parent { render :action => 'errors.rjs' } }
        format.html { redirect_to :action => :new }
      end
    end
  end
end
