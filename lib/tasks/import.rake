namespace :import do
  desc "Import data from spreadsheet" # update this line
  task data: :environment do
    puts 'Importing Data' # add this line
    data = Roo::Spreadsheet.open('lib/CENSO_DATOS_ABIERTOS_GENERAL_COVID_2020.xlsx') # open spreadsheet
    headers = data.row(1) # get header row

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

      puts('==================')
      puts(paciente.id_inicio_sintomas)
      paciente.save!

    end
  end
end
