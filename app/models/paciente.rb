class Paciente < ApplicationRecord
  has_one :informacion_temporal
  has_one :informacion_hospitalaria
  has_one :sintoma
end
