# -*- coding: utf-8 -*-
# Configures your navigation
SimpleNavigation::Configuration.run do |navigation|
  navigation.items do |primary|
      primary.item :student_requests, "Solicitudes de estudiantes asociados", academics_student_requests_path
      #primary.item :office_cubicles, "Administración de cubículos", academics_office_cubicles_path
  end
end
