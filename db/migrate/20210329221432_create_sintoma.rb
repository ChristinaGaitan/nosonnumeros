class CreateSintoma < ActiveRecord::Migration[6.1]
  def change
    create_table :sintomas do |t|
      t.belongs_to :paciente
      t.boolean :fiebre
      t.boolean :tos
      t.boolean :odinofagia
      t.boolean :disnea
      t.boolean :irritabilidad
      t.boolean :diarrea
      t.boolean :dolor_toracico
      t.boolean :escalofrios
      t.boolean :cefalea
      t.boolean :mialgias
      t.boolean :artralgias
      t.boolean :ataque_estado_general
      t.boolean :polipnea
      t.boolean :vomito
      t.boolean :dolor_abdminal
      t.boolean :conjuntivitis
      t.boolean :cianosis
      t.boolean :inicio_subito
      t.boolean :anosmia
      t.boolean :disgeusia

      t.timestamps
    end
  end
end
