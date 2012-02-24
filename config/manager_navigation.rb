# -*- coding: utf-8 -*-
# Configures your navigation
SimpleNavigation::Configuration.run do |navigation|
  navigation.items do |primary|
      primary.item :students, "Solicitudes de estudiantes asociados", managers_students_path
      primary.item :periods, "Periodos", managers_periods_path
      #primary.item :office_cubicles, "Administración de cubículos", academics_office_cubicles_path
  end
end
