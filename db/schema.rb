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

ActiveRecord::Schema.define(version: 2021_03_26_223143) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

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

end
