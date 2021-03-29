# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_03_29_221432) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "informacion_hospitalaria", force: :cascade do |t|
    t.bigint "paciente_id"
    t.string "institucion_tratante"
    t.string "unidad_notificante"
    t.boolean "toma_muestra_estado"
    t.string "status_dia_previo"
    t.string "tipo_manejo"
    t.string "status_paciente"
    t.string "resultado_laboratorio"
    t.boolean "requirio_intubacion"
    t.boolean "ingreso_uci"
    t.boolean "diagnostico_neumonia"
    t.string "diagnostico_probable"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["paciente_id"], name: "index_informacion_hospitalaria_on_paciente_id"
  end

  create_table "informacion_temporals", force: :cascade do |t|
    t.bigint "paciente_id"
    t.datetime "inicio_sintomas"
    t.datetime "periodo_minimo_incubacion"
    t.datetime "periodo_maximo_incubacion"
    t.datetime "estimada_alta_sanitaria"
    t.datetime "llegada_estado"
    t.datetime "toma_muestra"
    t.datetime "defuncion"
    t.datetime "resultado_laboratorio"
    t.string "semana_epidemiologica_defunciones"
    t.string "semana_epidemiologica_positivos"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["paciente_id"], name: "index_informacion_temporals_on_paciente_id"
  end

  create_table "pacientes", force: :cascade do |t|
    t.string "id_caso_positivo"
    t.string "id_inicio_sintomas"
    t.string "municipio"
    t.integer "edad"
    t.string "sexo"
    t.string "procedencia"
    t.string "ocupacion"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "sintomas", force: :cascade do |t|
    t.bigint "paciente_id"
    t.boolean "fiebre"
    t.boolean "tos"
    t.boolean "odinofagia"
    t.boolean "disnea"
    t.boolean "irritabilidad"
    t.boolean "diarrea"
    t.boolean "dolor_toracico"
    t.boolean "escalofrios"
    t.boolean "cefalea"
    t.boolean "mialgias"
    t.boolean "artralgias"
    t.boolean "ataque_estado_general"
    t.boolean "polipnea"
    t.boolean "vomito"
    t.boolean "dolor_abdminal"
    t.boolean "conjuntivitis"
    t.boolean "cianosis"
    t.boolean "inicio_subito"
    t.boolean "anosmia"
    t.boolean "disgeusia"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["paciente_id"], name: "index_sintomas_on_paciente_id"
  end

end
