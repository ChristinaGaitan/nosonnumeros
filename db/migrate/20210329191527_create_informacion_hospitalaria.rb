class CreateInformacionHospitalaria < ActiveRecord::Migration[6.1]
  def change
    create_table :informacion_hospitalaria do |t|
      t.belongs_to :paciente
      t.string  :institucion_tratante
      t.string  :unidad_notificante
      t.boolean :toma_muestra_estado
      t.string  :status_dia_previo
      t.string  :tipo_manejo
      t.string  :status_paciente
      t.string  :resultado_laboratorio
      t.boolean :requirio_intubacion
      t.boolean :ingreso_uci
      t.boolean :diagnostico_neumonia
      t.string  :diagnostico_probable

      t.timestamps
    end
  end
end
