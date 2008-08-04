class Admin::PhotosController < ApplicationController
  layout 'academic'

  def new
    @user_profile = UserProfile.find(params[:id])
    @record = Photo.new
    @record.moduser_id = session[:user_id]
    @record.user_id = params[:id]
    respond_to do |format|
      format.html { render :action => 'new'}
    end
  end
  
  def create
    @record = Photo.new(params[:photo])
    @record.moduser_id = session[:user_id]
    self.set_file(@record, :photo) 
    respond_to do |format|
      if @record.save
        format.html { redirect_to :action => :show, :id => @record.user_id }
        format.xml  { render :xml => @record, :status => :created, :location => @record }
      else
        format.html { redirect_to :action => :new, :id => @record.user_id }
      end
    end
  end
  
  def show
    @user_profile = UserProfile.find(params[:id])
    respond_to do |format|
      format.html { render :action => 'show'}
    end
  end
  
  def edit 
    @user_profile = UserProfile.find(params[:id])
    @record = Photo.find_by_user_id(params[:id])
    @record.moduser_id = session[:user_id]
    respond_to do |format|
      format.html { render :action => 'edit'}
    end
  end
  
  def update
    @record = Photo.find(params[:id])
    @record.moduser_id = session[:user_id]
    self.set_file(@record, :photo) 
    respond_to do |format|
      if @record.save
        format.html { redirect_to :action => :show, :id => @record.user_id }
      else
        format.html { redirect_to :action => :edit, :id => @record.user_id }
      end
    end
  end
  
  def destroy
    @record = Photo.find_by_user_id(params[:id])
    respond_to do |format|
      format.html { redirect_to :action => :new, :id => @record.user_id }
      @record.destroy
    end
  end
end
