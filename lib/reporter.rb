# encoding: utf-8
require 'spreadsheet'
Spreadsheet.client_encoding = 'UTF-8'
module Siesta

  class Reporter
      include ApplicationHelper

      def initialize(users, conditions={})
        @users = users
        @conditions = conditions
        @book = Spreadsheet::Workbook.new
        @ws = @book.create_worksheet
      end

      def set_col_names
        @ws.row(0).concat([ 'Nombre completo', 'Departamento', 'Académico responsable', 'Tipo de actividad', 'Periodo',
                            'No. de estudiante', 'Correo electrónico', 'Tipo', 'Status', 'Fecha de nacimiento',
                            'Carrera', 'Escuela o Facultad', 'Institución', 'Año de inicio', 'Año de término',
                            '¿Tiene rscritorio/Espacio asignado en el instituto?', 'Edificio', 'Cubículo/Árear de trabajo', 
                            'Escritorio', 'Horario', '¿Tiene alguna discapacidad?', 'Discapacidad', 'Requerimientos especiales'])
        @ws.row(0).default_format = Spreadsheet::Format.new :color => :black, :weight => :bold, :size => 12
      end

      def set_rows
        i = 1
        @users.each do |record|
          user_request = UserRequest.search(search_options(record.id, @conditions)).first
          adscription_name = user_request.adscription.nil? ? 'No definida' : user_request.adscription.name
          user_incharge = user_request.user_incharge.nil? ? 'No definido' : user_request.user_incharge.fullname
          role_name = user_request.role.nil? ? 'No definida' : user_request.role.name
          period_name = user_request.period.nil? ? 'No definido' : user_request.period.name

          career_name = record.most_recent_schooling.nil? ? 'No definida' : record.most_recent_schooling.career
          school_name = record.most_recent_schooling.nil? ?  'No definida' : record.most_recent_schooling.school
          institution_name = record.most_recent_schooling.nil? ? 'No definida' : record.most_recent_schooling.institution

          start_year = record.most_recent_schooling.nil? ? 'No definido' : record.most_recent_schooling.startyear
          end_year = record.most_recent_schooling.nil? ? 'No definido' : record.most_recent_schooling.endyear
          has_office = (user_request.had_desktop_in_previous_period?) ? 'Sí' : 'No'
          building_name = user_request.building.nil?? 'No definido' : user_request.building.name
          schedule_name = user_request.schedule.nil?? 'No definido' : user_request.schedule.name
          has_disability = user_request.has_disability?? 'Sí' : 'No'
          disability_name = user_request.disability.nil?? 'No definida' : user_request.disability.name

          @ws.row(i).concat([ record.fullname, adscription_name, user_incharge, role_name, period_name, record.code,
                              record.email, user_request.type, user_request.status, record.birthdate.to_s, career_name.to_s,
                              school_name.to_s, institution_name.to_s, start_year.to_s, end_year.to_s,
                              has_office, user_request.office, building_name, user_request.desktop, schedule_name,
                              has_disability, disability_name, user_request.special_requeriment])
          i += 1
        end
      end

      def file_path
         @path ||= Rails.root.to_s + "/tmp/student_report_#{Time.now.strftime("%Y%m%d%H%m%s")}.xls"
      end

      def build
        set_col_names
        set_rows
        @book.write(file_path)
      end
  end
end
