class Admin::SessionsController < SessionsController
  
  def login
     respond_to do |format|
       if SessionClient.authenticate?(params[:user][:login],params[:user][:passwd])
         session[:user_id] = User.find_by_login(params[:user][:login]).id
         flash[:notice] = "Bienvenido(a), ha iniciado una sesión en el SIESTA!"
         format.html { redirect_to(admin_user_requests_url) }
       else
         flash[:notice] = "El login o el password es incorrecto!"
         format.html { render :action => "index" }
       end
     end
  end
end
