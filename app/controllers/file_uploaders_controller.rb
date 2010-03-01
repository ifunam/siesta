class FileUploadersController < ApplicationController
  respond_to :html

  def index
    respond_with(@documents = UserDocument.where(:user_id => current_user.id))
  end

  def new
    respond_with(@document = UserDocument.new)
  end

  def create
    @document = UserDocument.new(params[:user_document])
    @document.user_id = current_user.id
    @document.save
    respond_with(@document, :status => :created, :location => file_uploaders_path ) 
  end

  def edit
    @document = UserDocument.find(params[:id])
    respond_with(@document)
  end

  def update
    @document = UserDocument.find(params[:id])
    @document.user_id = current_user.id
    @document.update_attributes(params[:user_document])
    respond_with(@document, :status => :created, :location => file_uploaders_path ) 
  end

  def destroy
    @document = UserDocument.find(params[:id])
    @document.destroy
    respond_with(@document, :status => :ok, :location => file_uploaders_path) 
  end
end