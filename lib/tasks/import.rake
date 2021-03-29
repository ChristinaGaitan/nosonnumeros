namespace :import do
  desc "Import data from spreadsheet"
  task data: :environment do
    puts 'Importing Data'
    data = Roo::Spreadsheet.open('lib/CENSO_DATOS_ABIERTOS_GENERAL_COVID_2020.xlsx') # open spreadsheet
    headers = data.row(1) # get header row

    data.each_with_index do |row, idx|
      next if idx == 0 # skip header

      paciente_data = Hash[[headers, row].transpose]

      # =====================================
      # Paciente
      # =====================================
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

      # =====================================
      # Informacion Temporal
      # =====================================
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

      # =====================================
      # Informacion Hospitalaria
      # =====================================
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
      paciente.informacion_hospitalaria = InformacionHospitalaria.new(hospitalaria_hash)

      # =====================================
      # Sintomas
      # =====================================
      sintomas_hash = {
        fiebre: paciente_data['Fiebre'],
        tos: paciente_data['Tos'],
        odinofagia: paciente_data['Odinofagia'],
        disnea: paciente_data['Disnea'],
        irritabilidad: paciente_data['Irritabilidad'],
        diarrea: paciente_data['Diarrea'],
        dolor_toracico: paciente_data['Dolor torácico'],
        escalofrios: paciente_data['Escalofríos'],
        cefalea: paciente_data['Cefalea'],
        mialgias: paciente_data['Mialgias'],
        artralgias: paciente_data['Artralgias'],
        ataque_estado_general: paciente_data['Ataque al estado general'],
        polipnea: paciente_data['Polipnea'],
        vomito: paciente_data['Vómito'],
        dolor_abdminal: paciente_data['Dolor abdminal'],
        conjuntivitis: paciente_data['Conjuntivitis'],
        cianosis: paciente_data['Cianosis'],
        inicio_subito: paciente_data['Inicio súbito'],
        anosmia: paciente_data['Anosmia'],
        disgeusia: paciente_data['Disgeusia'],
      }

      sintomas_hash.each do |key, value|
        new_value = value == 'SE IGNORA' ? nil : (value == 'SI' || value == 'S')
        sintomas_hash[key] = new_value
      end

      paciente.sintomas = Sintomas.new(sintomas_hash)

      # =====================================
      # Enfermedades Previas
      # =====================================
      enfermedades_hash = {
        diabetes: paciente_data['Diabetes'],
        epoc: paciente_data['EPOC'],
        asma: paciente_data['Asma'],
        inmunosupresion: paciente_data['Inmunosupresión'],
        hipertension: paciente_data['Hipertensión'],
        vih_sida: paciente_data['VIH/SIDA'],
        otra_condicion: paciente_data['Otra condición'],
        enfermedad_cardiaca: paciente_data['Enfermedad cardiaca'],
        obesidad: paciente_data['Obesidad'],
        insuficiencia_renal_cronica: paciente_data['Insuficiencia renal crónica'],
        tabaquismo: paciente_data['Tabaquismo'],
      }

      enfermedades_hash.each do |key, value|
        new_value = value == 'SE IGNORA' ? nil : (value == 'SI' || value == 'S')
        enfermedades_hash[key] = new_value
      end

      paciente.enfermedades_previas = EnfermedadesPrevias.new(enfermedades_hash)

      puts('==================')
      puts(paciente.id_inicio_sintomas)
      puts(paciente.informacion_temporal.inicio_sintomas)
      puts(paciente.informacion_hospitalaria.institucion_tratante)
      puts(paciente.sintomas.fiebre)
      puts(paciente.enfermedades_previas.diabetes)
      paciente.save!
    end
  end
end
