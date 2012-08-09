class RemoteUsersController < ApplicationController
  respond_to :html
  def index
    respond_with(@collection = AdscriptionClient.find(params[:adscription_id]).users, :layout => false)
  end
end
