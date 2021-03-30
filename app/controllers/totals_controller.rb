class TotalsController < ApplicationController
  before_action :set_total, only: %i[ show edit update destroy ]

  # GET /totals or /totals.json
  def index
    @totals = Total.all
  end

  # GET /totals/1 or /totals/1.json
  def show
  end

  # GET /totals/new
  def new
    @total = Total.new
  end

  # GET /totals/1/edit
  def edit
  end

  # POST /totals or /totals.json
  def create
    @total = Total.new(total_params)

    respond_to do |format|
      if @total.save
        format.html { redirect_to @total, notice: "Total was successfully created." }
        format.json { render :show, status: :created, location: @total }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @total.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /totals/1 or /totals/1.json
  def update
    respond_to do |format|
      if @total.update(total_params)
        format.html { redirect_to @total, notice: "Total was successfully updated." }
        format.json { render :show, status: :ok, location: @total }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @total.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /totals/1 or /totals/1.json
  def destroy
    @total.destroy
    respond_to do |format|
      format.html { redirect_to totals_url, notice: "Total was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_total
      @total = Total.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def total_params
      params.fetch(:total, {})
    end
end
