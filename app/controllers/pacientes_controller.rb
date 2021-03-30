class PacientesController < ApplicationController
  before_action :set_paciente, only: %i[ show edit update destroy ]

  # GET /pacientes or /pacientes.json
  def index
    @pacientes = Paciente.last(50)
  end

  # GET /pacientes/1 or /pacientes/1.json
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_paciente
      @paciente = Paciente.find(params[:id])
    end
end
