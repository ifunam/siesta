class SharedController < ApplicationController
  def initialize
    @hash_name  = Inflector.tableize(@model).singularize.to_sym
    @columns = @model.column_names - %w(id user_id created_at updated_at moduser_id)
    @find_options = { }
   end

  def index
    @collection = Finder.new(@model, :all, :attributes => @columns, :conditions => "#{Inflector.tableize(@model)}.user_id = #{session[:user]}").as_pair
    respond_to do |format|
      if request.xhr?
        format.html { render :action => 'index', :layout => false }
      else
        format.html { render :action => 'index' }
      end
      format.xml { render :xml => @collection }
    end
  end

  def show
    @finder = Finder.new(@model, :first, :attributes => @columns,  :conditions => "#{Inflector.tableize(@model)}.id = #{params[:id]}")
    respond_to do |format|
      format.html { render :partial => 'shared/show', :layout => false}
    end
  end

  def new
    @record = @model.new
    respond_to do |format|
      if request.xhr?
        format.html { render :partial => 'shared/new', :layout => false }
      else
        format.html { render :action => 'new'}
      end
      format.xml  { render :xml => @record }
    end
  end

  def edit
    @record = @model.find(params[:id])
    respond_to do |format|
      format.js { render :partial => 'shared/edit.rjs'}
     end
  end

  def create
    @record = @model.new(params[@hash_name])
    self.set_user(@record)
    self.set_file(@record, @hash_name) if @record.has_attribute? 'file'
    respond_to do |format|
      if @record.save
        format.js { responds_to_parent { render :partial => 'shared/create.rjs' } }
        format.xml  { render :xml => @record, :status => :created, :location => @record }
      else
        format.js { responds_to_parent { render :partial => 'shared/errors.rjs' } }
        format.xml  { render :xml => @record.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @record = @model.find(params[:id])
    respond_to do |format|
      if @record.update_attributes(params[@hash_name])
        format.js { responds_to_parent { render :partial => 'shared/update.rjs' } }
        format.xml { head :ok }
      else
        format.js { responds_to_parent { render :partial => 'shared/errors.rjs' } }
        format.xml { render :xml => @record.errors, :status => :unprocessable_entity }
      end
    end
 end

  def destroy
    @record = @model.find(params[:id])
    @record.destroy
    respond_to do |format|
      if request.xhr?
        format.js { render :partial => 'shared/destroy.rjs' }
      else
        format.html { redirect_to  :action => :index }
       end
    end
  end

  def destroy_all
    @collection = params[:id].collect { |id| @model.find(id) }
    respond_to do |format|
      format.js { render :partial => 'shared/destroy_id.rjs',  :collection => @collection }
    end
    @model.delete(@collection.collect {|record| record.id })
   end
end
