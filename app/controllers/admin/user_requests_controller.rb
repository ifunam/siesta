class Admin::UserRequestsController < ApplicationController
  layout 'admin'
  def index
    session[:query] = { :period_id =>  Period.most_recent.id, :requeststatus_id => 3 }
    @collection = UserRequest.search_with_paginate(session[:query], params[:page])
    respond_to do |format|
      format.html { render :action => :index }
    end
  end

  def search
    session[:query] = params[:search] if params[:search]
    @collection = UserRequest.search_with_paginate(session[:query], params[:page])
    respond_to do |format|
      format.html { render :action => :index }
    end
  end
  
  def show
    @user_request = UserRequestRequirement.find(params[:id])
    @user_profile = UserProfile.find(params[:id])
    respond_to do |format|
      format.html { render :action => :show }
    end
  end
end
