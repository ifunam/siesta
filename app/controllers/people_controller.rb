class PeopleController < ApplicationController
  helper :select
  def index
    unless Person.find(:first, :conditions => ['user_id = ?', session[:user]]).nil?
      redirect_to :action => 'show'
    else
     redirect_to :action  => 'new'
    end
  end

  def show
    @person = Person.find(:first, :conditions => ['user_id = ?', session[:user]])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @userstatus }
    end
  end

  def new
    @person = Person.new
  end

  def edit
    @person = Person.find(:first, :conditions => ['user_id = ?', session[:user]])
  end

  def create
    @person = Person.new(params[:person])
    @city = City.new(params[:city])
    @city.state_id = @person.state_id.nil? ? 83 : @person.state_id
    self.set_user(@city)
    @person.city = @city
    self.set_user(@person)
    if @person.valid?
      @person.save
      flash[:notice] = 'Sus datos personales han sido guardados'
      redirect_to :action => 'index'
    else
      flash[:notice] = 'Hay errores al guardar esta información'
      render :action => 'new'
    end
  end

  def update
    @person = Person.find(:first, :conditions => ['user_id = ?', session[:user]])
    @city = City.new(params[:city])
    @city.state_id = @person.state_id.nil? ? 83 : @person.state_id
    self.set_user(@city)
    @person.city = @city
    self.set_user(@person)
    if @person.update_attributes(params[:person])
        flash[:notice] = 'Sus datos personales han sido actualizados'
        render :action => 'show'
    else
      flash[:notice] = 'Hay errores al actualizar esta información'
      render :action => 'edit'
    end
  end
end

