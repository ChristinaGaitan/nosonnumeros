class CreatePacientes < ActiveRecord::Migration[6.1]
  def change
    create_table :pacientes do |t|
      t.string  :id_caso_positivo
      t.string  :id_inicio_sintomas
      t.string  :municipio
      t.integer :edad
      t.string  :sexo
      t.string  :procedencia
      t.string  :ocupacion

      t.timestamps
    end
  end
end
