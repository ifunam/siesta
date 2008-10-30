require 'rubygems'
require 'iconv'
require 'spreadsheet/excel'
include Spreadsheet
class Admin::UserRequestsController < ApplicationController
  layout 'admin'
  def index
    session[:query] = { :period_id =>  Period.most_recent.id, :requeststatus_id => 3 }
    @collection = UserRequest.search_with_paginate(session[:query], params[:page])
    respond_to do |format|
      format.html { render :action => :index }
    end
  end

  def search
    session[:query] = params[:search] if params[:search]
    @collection = UserRequest.search_with_paginate(session[:query], params[:page])
    respond_to do |format|
      format.html { render :action => :index }
    end
  end

  def report
    @collection = UserRequest.search(:conditions => session[:query])
    workbook = Excel.new(RAILS_ROOT + "/tmp/report.xls")
    worksheet = workbook.add_worksheet('Reporte')
    row = 0
    worksheet.write(row, 0, Iconv.conv("ISO-8859-1","UTF-8",'Correo electrónico'))
    worksheet.write(row, 1, 'Nombre completo')
    worksheet.write(row, 2, 'Grado reciente o actual')
    worksheet.write(row, 3, 'Actividad que realiza')
    worksheet.write(row, 4, Iconv.conv("ISO-8859-1","UTF-8",'Responsable académico'))
    worksheet.write(row, 5, 'Departamento')
    row += 1
    @collection.each do |record|
      if record.user.email =~ /fisica.unam.mx/
      @profile = UserProfile.find(record.user_id)
      worksheet.write(row, 0, Iconv.conv("ISO-8859-1","UTF-8", record.user.email))
      worksheet.write(row, 1, Iconv.conv("ISO-8859-1","UTF-8", @profile.fullname))
      worksheet.write(row, 2, Iconv.conv("ISO-8859-1","UTF-8", @profile.most_recent_schooling.degree.name))
      worksheet.write(row, 3, Iconv.conv("ISO-8859-1","UTF-8", @profile.student_type))
      worksheet.write(row, 4, Iconv.conv("ISO-8859-1","UTF-8", @profile.academic_incharge))
      worksheet.write(row, 5, Iconv.conv("ISO-8859-1","UTF-8", @profile.department))
      row +=1
      end
    end
    workbook.close
    respond_to do |format|
        format.xls { send_file RAILS_ROOT + "/tmp/report.xls", :type => "application/vnd.ms-excel", :disposition => 'attachment' }
    end
  end
  
  def show
    @user_request = UserRequestRequirement.find(params[:id])
    @user_profile = UserProfile.find(params[:id])
    respond_to do |format|
      format.html { render :action => :show }
    end
  end
end
