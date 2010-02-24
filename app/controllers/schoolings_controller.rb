class SchoolingsController < ApplicationController
  respond_to :html
  def index
    @schoolings = Schooling.find_all_by_user_id(current_user.id)
    respond_with(@schoolings)
  end

  def new
    @schooling = Schooling.new
    respond_with(@schooling)
  end

  def create
    @schooling = Schooling.new(params[:schooling])
    @schooling.user_id = current_user.id
    flash[:notice] = "Your schooling has been saved" if @schooling.save
    respond_with(@schooling) do |format|
      format.html { redirect_to schoolings_path }
    end
  end

  def edit
    @schooling = Schooling.find(params[:id])
    respond_with(@schooling)
  end

  def update
    @schooling = Schooling.find(params[:id])
    @schooling.user_id = current_user.id
    flash[:notice] = "Your schooling has been saved" if @schooling.update_attributes(params[:schooling])
    respond_with(@schooling) do |format|
      format.html { redirect_to schoolings_path }
    end
  end

  def destroy
    @schooling = Schooling.find(params[:id])
    flash[:notice] = "Your document has been deleted" if @schooling.destroy
    respond_with(@schooling)
  end
end
