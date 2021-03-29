class CreateEnfermedadesPrevias < ActiveRecord::Migration[6.1]
  def change
    create_table :enfermedades_previas do |t|
      t.belongs_to :paciente
      t.boolean :diabetes
      t.boolean :epoc
      t.boolean :asma
      t.boolean :inmunosupresion
      t.boolean :hipertension
      t.boolean :vih_sida
      t.boolean :otra_condicion
      t.boolean :enfermedad_cardiaca
      t.boolean :obesidad
      t.boolean :insuficiencia_renal_cronica
      t.boolean :tabaquismo

      t.timestamps
    end
  end
end
