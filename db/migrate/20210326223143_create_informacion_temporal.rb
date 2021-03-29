class CreateInformacionTemporal < ActiveRecord::Migration[6.1]
  def change
    create_table :informacion_temporals do |t|
      t.belongs_to :paciente
      t.datetime :inicio_sintomas
      t.datetime :periodo_minimo_incubacion
      t.datetime :periodo_maximo_incubacion
      t.datetime :estimada_alta_sanitaria
      t.datetime :llegada_estado
      t.datetime :toma_muestra
      t.datetime :defuncion
      t.datetime :resultado_laboratorio
      t.string :semana_epidemiologica_defunciones
      t.string :semana_epidemiologica_positivos

      t.timestamps
    end
  end
end
