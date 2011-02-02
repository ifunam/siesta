class Managers::EmailsController < Managers::ApplicationController
 skip_before_filter :verify_authenticity_token, :only => [:update]
 def new
   @student = StudentProfile.find(params[:id])
   @user = LDAP::User.new
 end

 def create
   @user = LDAP::User.new(params[:user])
   @student = StudentProfile.find(params[:student][:id])
   if @user.save
       @student.update_attribute(:email, params[:user][:login] + '@fisica.unam.mx')
     redirect_to managers_email_path(@student)
   else
     render :action => :new
   end
 end

 def show
   @student = StudentProfile.find(params[:id])
   @users = []
   @student.fullname.split(' ').each do |name|
    @users += LDAP::User.all_by_fullname_likes(name.strip)
   end
 end

 def update
    @user = User.find(params[:id])
    @user.email = params[:email]
    if @user.save
      redirect_to managers_email_path(@user)
    else
      redirect_to managers_email_path(@user)
    end
 end
end
