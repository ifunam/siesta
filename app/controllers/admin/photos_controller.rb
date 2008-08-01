class Admin::PhotosController < ApplicationController
  layout 'academic'

  def index
    @record = Photo.find_by_user_id(params[:id])
    respond_to do |format|
      unless @record.nil?
        format.html { render :action => 'show'  }
        format.js   { render :action => 'show.rjs'}
      else
        @record = @model.new
        format.html { render :action => 'new', :id =>  params[:id] }
        format.js { render :action => 'new.rjs' }
      end
    end
  end
  alias_method :show, :index 

  def new
    @record = Photo.new
    @record.user_id ||= params[:id]
    respond_to do |format|
      format.js { render :action => 'new.rjs' }
      format.html { render :action => 'new'}
      format.xml  { render :xml => @record }
    end
  end
  
  def edit 
    @record = Photo.find(params[:id])
    respond_to do |format|
      format.js { render :action => 'edit.rjs' }
      format.html { render :action => 'edit'}
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
  
  def update
    @record = Photo.find(params[:id])
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
  
  def destroy
    @record = Photo.find_by_user_id(session[:user_id])
    @record.destroy
    respond_to do |format|
      format.html { redirect_to :action => :index }
      format.js { render :action => 'destroy.rjs' }
    end
  end
end
