class ProfilesController < ApplicationController
	respond_to :html
	
	def edit
	   @user = User.find(current_user.id)
	   respond_with(@user)
	end
	
	def update
	    @user = User.find(current_user.id)
	    flash[:notice] = 'Your data has been saved' if @user.update_attributes(params[:user])
		respond_with(@user)
    end

	def show
		@user = User.find(current_user.id)
		render 'new'
	end
end
