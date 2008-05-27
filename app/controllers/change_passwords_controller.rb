class ChangePasswordsController < ApplicationController
  def show
    @record = User.find(session[:user])
    @record.passwd = nil
    params = { :action => 'show' }
    params[:layout] = false if request.xhr?
    respond_to do |format|
      format.html { render params }
    end
  end

  def update
    @record = User.find(session[:user])
    respond_to do |format|
      if @record.update_attributes(params[:user])
        format.js { render :action => 'update.rjs' }
        format.xml  { head :ok }
      else
        format.js { render :partial => "shared/errors.rjs" }
        format.xml  { render :xml => @record.errors, :status => :unprocessable_entity }
      end
    end
  end
end