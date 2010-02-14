class FileUploadersController < ApplicationController
    respond_to :html
	def index
	  @documents = UserDocument.all(:conditions => { :user_id => current_user.id })
	  respond_with(@documents)
	end
	
	def new
	  @document = UserDocument.new
	  respond_with(@document)
	end

	def create
	  @document = UserDocument.new(params[:user_document])
	  @document.user_id = current_user.id
	  flash[:notice] = "Your document has been saved" if @document.save
	  respond_with(@document) do |format|
	 	 format.html { redirect_to file_uploaders_path }
	  end	
	end

	def edit
	  @document = UserDocument.find(params[:id])
	  respond_with(@document)
	end

	def update
	  @document = UserDocument.find(params[:id])
	  @document.user_id = current_user.id
	  flash[:notice] = "Your document has been saved" if @document.update_attributes(params[:user_document])
	  respond_with(@document) do |format|
	 	 format.html { redirect_to file_uploaders_path }
	  end
	end
	
	def destroy
	  @document = UserDocument.find(params[:id])
	  flash[:notice] = "Your document has been deleted" if @document.destroy
	  respond_with(@document)
	end
end