class Managers::EmailsController < Managers::ApplicationController

 def new
   @student = StudentProfile.find(params[:id])
 end

 def create
   @user = LDAP::User.new(params[:user])
   if @user.save
     redirect_to managers_email_path(params[:student][:id])
   else
    redirect_to new_managers_email_path(:id => params[:student][:id])
   end
 end

 def show
   @student = StudentProfile.find(params[:id])
   @users = LDAP::User.find_all_by_fullname(@student.person.firstname.split(' ').first.strip)
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
