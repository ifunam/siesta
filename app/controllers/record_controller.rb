class RecordController < ApplicationController
  def initialize
    @hash_name  = Inflector.tableize(@model).singularize.to_sym
    @columns = @model.column_names - %w(id user_id created_at updated_at moduser_id)
  end

  def show
    unless @model.find(:first, :conditions => ['user_id = ?', session[:user]]).nil?
      @finder = Finder.new(@model, :first, :attributes => @columns,  :conditions => "#{Inflector.tableize(@model)}.user_id = #{session[:user]}")
      @pairs = @finder.record_as_pair
      options = { :action => 'show' }
      options[:layout] = false if request.xhr?
      respond_to do |format|
        format.html { render options }
      end
    else
      render :update do |page|
        page.hide 'form'
        page.redirect_to :action => 'new'
      end
    end
  end

  def new
    @record = @model.new
    options = { :action => 'new' }
    options[:layout] = false if request.xhr?
    respond_to do |format|
      format.html { render options }
    end
  end

  def create
    @record = @model.new(params[@hash_name])
    self.set_user(@record)
    self.set_quickposts(@record)
    respond_to do |format|
      if  @record.save
        format.html { redirect_to :action => 'show' }
      else
        format.js { render :partial => 'shared/errors.rjs' }
      end
    end
  end

  def edit
    @record = @model.find(:first, :conditions => ['user_id = ?', session[:user]])
    respond_to do |format|
      format.html { render :partial=> 'record_controller/edit', :layout => false }
    end
  end

  def update
    @record = @model.find(:first, :conditions => ['user_id = ?', session[:user]])
    self.set_user(@record)
    self.set_quickposts(@record)
    respond_to do |format|
      if  @record.update_attributes(params[@hash_name])
        format.html { redirect_to :action => 'show' }
      else
        format.js { render :partial => 'shared/errors.rjs' }
      end
    end
  end
  
  protected
  def set_quickposts(record)
    params[:quickposts].keys.each do |k|
      record.send k+'=', Inflector.classify(k).constantize.new(params[:quickposts][k])
      record.[]=("#{k}_id", nil)
    end
  end
end