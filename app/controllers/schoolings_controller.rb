class SchoolingsController < ApplicationController
  respond_to :html
  def index
    @schoolings = Schooling.find_all_by_user_id(current_user.id)
    respond_with(@schoolings)
  end

  def new
    respond_with(@schooling = Schooling.new)
  end

  def create
    @schooling = Schooling.new(params[:schooling].merge(:user_id => current_user.id))
    @schooling.save
    respond_with(@schooling, :status => :created, :location => schoolings_path)
  end

  def edit
    @schooling = Schooling.find(params[:id])
    respond_with(@schooling)
  end

  def update
    @schooling = Schooling.find(params[:id])
    @schooling.update_attributes(params[:schooling].merge(:user_id => current_user.id))
    respond_with(@schooling, :status => :updated, :location => schoolings_path)
  end

  def destroy
    @schooling = Schooling.find(params[:id])
    @schooling.destroy
    respond_with(@schooling)
  end
end
