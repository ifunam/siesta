class UsersController < ApplicationController
  skip_before_filter :require_login, :only => [:new, :create] 
  
  # caches_action :new
  layout 'session'
  respond_to :html

  def new
    respond_with(@user = User.new)
  end

  def create
    respond_with(@user = User.create(params[:user]), :status => :created)
  end
end