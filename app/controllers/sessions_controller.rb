class SessionsController < ApplicationController
  skip_before_filter :login_required
  def index
    respond_to do |format|
      format.html # index.html.erb
    end
  end

  def new
    @user = User.new
    respond_to do |format|
      format.html # new.html.erb
    end
  end

  def create
    @user = User.new(params[:user])
    respond_to do |format|
      if @user.save
        UserNotifier.deliver_new_notification(@user, url_for(:action => 'confirm', :id => @user.id, :token => @user.token))
        flash[:notice] = 'Su cuenta ha sido creada.'
        format.html { render :action => 'created' }
      else
        @user.passwd = nil
        format.html { render :action => "new" }
        format.xml { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  def confirm
    @user = User.find(:first, :conditions => [ 'id = ? AND token = ? AND token_expiry >= ?', params[:id], params[:token], 5.minutes.from_now ])
    respond_to do |format|
      if !@user.nil?
        @user.confirm
        reset_session # Reset old sessions if exists
        UserNotifier.deliver_activation(@user, url_for(:action => 'index'))
        format.html { render :action => "activated" }
        format.xml { head :ok }
      else
        flash[:notice] = 'La liga para activar su cuenta ha expirado.'
        format.html { render :action => "index" }
      end
    end
  end

  def login
    respond_to do |format|
      if User.authenticate?(params[:user][:login],params[:user][:passwd])
        session[:user] = User.find_by_login(params[:user][:login]).id
        flash[:notice] = "Bienvenido (a), ha iniciado una sesión en el SIESTA!"
        format.html { session[:return_to] ? redirect_to(session[:return_to]) : redirect_to(:controller => 'person') }
      else
        flash[:notice] = "El login o el password es incorrecto!"
        format.html { render :action => "index" }
      end
    end
  end

  def login_by_token
    respond_to do |format|
      if User.authenticate_by_token?(params[:login], params[:token])
        @user =  User.find_by_login(params[:login])
        session[:user] = @user.id
        @user.token = nil
        @user.save
        flash[:notice] = "Bienvenido(a), por favor cambie su contraseña..."
        format.html { redirect_to :controller => 'change_passwd', :action => 'new' }
      else
        flash[:notice] = "La información es inválida!"
        format.html { render :action => "index" }
      end
    end
  end

  def destroy
    reset_session
    respond_to do |format|
      format.html {  render :action => "logout" }
    end
  end

  def recovery_passwd
    @user = User.find(:first, :conditions => ['email = ?', params[:user]['email']])
    respond_to do |format|
      if !@user.nil?
        @user.new_token
        UserNotifier.deliver_password_recovery(@user, url_for(:action => 'login_by_token', :id => @user.id, :login => @user.login, :token => @user.token))
        format.html { render :action => 'recovery_passwd'}
        format.xml { head :ok }
      else
        flash[:notice] = "El correo #{params[:user]['email']} NO existe en el sistema!"
        format.html { render :action => "password_recovery_request" }
      end
    end
  end
end
