namespace :import do
  desc "Import data from spreadsheet" # update this line
  task data: :environment do
    puts 'Importing Data' # add this line
    data = Roo::Spreadsheet.open('lib/CENSO_DATOS_ABIERTOS_GENERAL_COVID_2020.xlsx') # open spreadsheet
    headers = data.row(1) # get header row

    nil_values = ['NA', 'Temporal', '', 'No aplica']

    data.each_with_index do |row, idx|
      next if idx == 0 # skip header

      # create hash from headers and cells
      paciente_data = Hash[[headers, row].transpose]

      paciente_hash = {
        id_caso_positivo: paciente_data['No de caso positivo por inicio de síntomas'],
        id_inicio_sintomas: paciente_data['No consecutivo por inicio de síntomas'],
        municipio: paciente_data['Municipio de residencia'],
        edad: paciente_data['Edad'],
        sexo: paciente_data['Sexo'],
        procedencia: paciente_data['Procedencia'],
        ocupacion: paciente_data['Ocupación']
      }
      paciente_hash.each { |key, value| paciente_hash[key] = value == 'NA' || value == 'No aplica' ? nil : value }
      paciente = Paciente.new(paciente_hash)

      fechas_hash = {
        inicio_sintomas: paciente_data['Fecha de inicio de síntomas'],
        periodo_minimo_incubacion: paciente_data['Periodo mínimo de incubación (2 días)'],
        periodo_maximo_incubacion: paciente_data['Periodo máximo de incubación (7 días)'],
        estimada_alta_sanitaria: paciente_data['Fecha estimada de Alta Sanitaria'],
        llegada_estado: paciente_data['Fecha de llegada al Estado'],
        toma_muestra: paciente_data['Fecha de toma de muestra'],
        defuncion: paciente_data['Fecha de la defunción'],
        semana_epidemiologica_defunciones: paciente_data['Semana epidemiológica de defunciones positivas'],
        semana_epidemiologica_positivos: paciente_data['Semana epidemiológica de resultados positivos'],
        resultado_laboratorio: paciente_data['Fecha de resultado de laboratorio']
      }

      fechas_hash.each do |key, value|
        new_value = nil
        if key == :semana_epidemiologica_defunciones || key == :semana_epidemiologica_positivos
          # String values
          new_value = value&.empty? ? nil : value
          # if value&.empty?
          #   new_value = nil
          # else
          #   new_value = value
          # end
        else
          # Date values
          new_value = value.is_a?(String) ? nil : value
          # if value.is_a?(String)
          #   new_value = nil
          # else
          #   new_value = value
          # end
        end
        fechas_hash[key] = new_value
      end

      paciente.informacion_temporal = InformacionTemporal.new(fechas_hash)
      # puts('==================')
      # puts(paciente.id_inicio_sintomas)
      # puts(paciente.informacion_temporal.inicio_sintomas)
      paciente.save!
    end
  end
end
