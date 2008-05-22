# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time

  before_filter :login_required
  before_filter :navigator

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  #protect_from_forgery # :secret => '3ae605004c29b251466d3bbae32d99c5'

  def navigator
    @tree = Tree.find_by_data('default')
  end

  def update_partial
    render :partial => params[:partial]
  end

  def update_select
      render :partial => params[:partial], :locals => { :id => params[:id], :object => params[:object], :default => params[:default] }
  end
  
  def set_user(model)
    unless session[:user].nil?
      model.user_id = session[:user] if model.has_attribute? 'user_id'
      model.moduser_id = session[:user] if model.has_attribute? 'user_id'
    end
  end

  def set_file(model,form_key=nil)
    if !model.file.nil? && (model.file.class == ActionController::UploadedTempfile || model.file.class == ActionController::UploadedStringIO)
        model.file = model.file.read
        form_key = form_key.nil? ? Inflector.tableize(model.class.name).singularize.to_sym : form_key
        model.content_type = params[form_key][:file].content_type.chomp.to_s
        model.filename = params[form_key][:file].original_filename.chomp
    end
  end

  def login_required
    store_location
    (!session[:user].nil? and !User.find(session[:user]).nil?) ? (return true) : (redirect_to :controller=> :sessions and return false)
  end

  def store_location
    session[:return_to] = request.request_uri
  end

end
