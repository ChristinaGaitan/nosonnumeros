class TotalsController < ApplicationController
  before_action :set_total, only: %i[ show edit update destroy ]

  # GET /totals or /totals.json
  def index
    @totals = Total.all
  end

  # GET /totals/1 or /totals/1.json
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_total
      @total = Total.find(params[:id])
    end
end
