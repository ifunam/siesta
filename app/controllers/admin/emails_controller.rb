class Admin::EmailsController < Admin::ApplicationController
 layout 'academic'

 def new
   @student = StudentProfile.find(params[:id])
   @user = LocalUser.new
 end
 
 def create
   @student = StudentProfile.find(params[:student][:id])
   @user = LocalUser.new(params[:local_user].merge(:gecos => @student.person.fullname_firstname))

   if @user.save
     email = params[:local_user][:username] + '@fisica.unam.mx'
     @student.update_attributes(:email => email)
     Notifier.new_local_user(@user.username, @user.passwd, @user.gecos).deliver
     redirect_to admin_email_path(@student.id)
   else
    redirect_to new_admin_email_path(:id => @student.id)
   end
 end
 
 def show
   @student = StudentProfile.find(params[:id])
   @unix_users = LocalUser.gecos_like(@student.fullname)
 end
 
 def update
    @student = StudentProfile.find(params[:id])
    @student.email = params[:email]
    if @student.save
      redirect_to admin_email_path(@student.id)
    else
      redirect_to admin_email_path(@student.id)
    end
 end
end