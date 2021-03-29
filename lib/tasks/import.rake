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
        else
          # Date values
          new_value = value.is_a?(String) ? nil : value
        end
        fechas_hash[key] = new_value
      end
      paciente.informacion_temporal = InformacionTemporal.new(fechas_hash)

      hospitalaria_hash = {
        institucion_tratante: paciente_data['Institución tratante'],
        unidad_notificante: paciente_data['Unidad notificante'],
        toma_muestra_estado: paciente_data['Toma de muestra en el ESTADO'],
        status_dia_previo: paciente_data['Estatus día previo'],
        tipo_manejo: paciente_data['Tipo de manejo'],
        status_paciente: paciente_data['Estatus del paciente'],
        resultado_laboratorio: paciente_data['Resultado de laboratorio'],
        requirio_intubacion: paciente_data['Pacientes que requirieron intubación'],
        ingreso_uci: paciente_data['Pacientes que ingresaron a UCI'],
        diagnostico_neumonia: paciente_data['Diagnóstico clínico de Neumonía'],
        diagnostico_probable: paciente_data['Diagnóstico probable'],
      }

      hospitalaria_hash.each do |key, value|
        new_value = nil
        if key == :toma_muestra_estado || key == :requirio_intubacion || key == :ingreso_uci || key == :diagnostico_neumonia
          # Boolean values
          new_value = value == 'SI'
        else
          # String values
          new_value = value&.empty? ? nil : value
        end
        hospitalaria_hash[key] = new_value
      end

      puts(hospitalaria_hash)
      paciente.informacion_hospitalaria = InformacionHospitalaria.new(hospitalaria_hash)

      puts('==================')
      puts(paciente.id_inicio_sintomas)
      puts(paciente.informacion_temporal.inicio_sintomas)
      puts(paciente.informacion_hospitalaria.institucion_tratante)
      paciente.save!
    end
  end
end
