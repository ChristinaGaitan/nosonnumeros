class Paciente < ApplicationRecord
  has_one :informacion_temporal
  has_one :informacion_hospitalaria
end
