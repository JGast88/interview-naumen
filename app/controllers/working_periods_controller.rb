class WorkingPeriodsController < ApplicationController
  before_action :set_working_period, only: %i[ show edit update destroy ]

  # GET /working_periods or /working_periods.json
  def index
    @working_periods = WorkingPeriod.all
  end

  # GET /working_periods/1 or /working_periods/1.json
  def show
  end

  # GET /working_periods/new
  def new
    @working_period = WorkingPeriod.new
    @departments = Department.all
    @people = Person.all
  end

  # GET /working_periods/1/edit
  def edit
  end

  # POST /working_periods or /working_periods.json
  def create
    @working_period = WorkingPeriod.new(working_period_params)

    respond_to do |format|
      if @working_period.save
        format.html { redirect_to @working_period.department, notice: "Working period was successfully created." }
        format.json { render :show, status: :created, location: @working_period }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @working_period.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /working_periods/1 or /working_periods/1.json
  def update
    respond_to do |format|
      if @working_period.update(working_period_params)
        format.html { redirect_to @working_period.department, notice: "Working period was successfully updated." }
        format.json { render :show, status: :ok, location: @working_period }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @working_period.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /working_periods/1 or /working_periods/1.json
  def destroy
    @working_period.destroy
    respond_to do |format|
      format.html { redirect_to working_periods_url, notice: "Working period was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_working_period
      @working_period = WorkingPeriod.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def working_period_params
      params.require(:working_period).permit(:start_at, :end_at, :department_id, :person_id)
    end
end
