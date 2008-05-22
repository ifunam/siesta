class RecordController < ApplicationController
  def initialize
    @hash_name  = Inflector.tableize(@model).singularize.to_sym
    @columns = @model.column_names - %w(id user_id created_at updated_at moduser_id)
  end

  def show
    unless @model.find(:first, :conditions => ['user_id = ?', session[:user]]).nil?
      @finder = Finder.new(@model, :first, :attributes => @columns,  :conditions => "#{Inflector.tableize(@model)}.user_id =  2")
      @pairs = @finder.record_as_pair
      respond_to do |format|
        if request.xhr?
          format.html { render :record => 'show', :layout => false }
        else
          format.html { render :record => 'show' }
        end
      end
    else
      respond_to do |format|
        format.html { redirect_to :action => 'new' }
      end
    end
  end

  def new
    @record = @model.new
    respond_to do |format|
        if request.xhr?
          format.html { render :record => 'new', :layout => false }
        else
          format.html { render :record => 'new' }
        end
    end
  end

  def create
    @record = @model.new(params[:person])
    self.set_user(@record)
    respond_to do |format|
      if  @record.save
        format.html {redirect_to :action => 'show'}
      else
        format.js {render :partial => 'shared/errors.rjs'}
      end
    end
  end

  def edit
    @record = @model.find(:first, :conditions => ['user_id = ?', session[:user]])
    respond_to do |format|
      format.html {render :partial=> 'record_controller/edit', :layout => false }
    end
  end

  def update
    @record = @model.find(:first, :conditions => ['user_id = ?', session[:user]])
    self.set_user(@record)
    respond_to do |format|
      if  @record.update_attributes(params[:person])
        format.html {redirect_to :action => 'show'}
      else
        format.js {render :partial => 'shared/errors.rjs'}
      end
    end
  end

  private
  def set_quickposts
  end
end
