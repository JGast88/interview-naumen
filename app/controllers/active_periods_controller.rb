class ActivePeriodsController < ApplicationController

  def new
    @active_period = ActivePeriod.new
  end

  def create
    @active_period = ActivePeriod.new(active_period_params)

    respond_to do |format|
      if @active_period.save
        format.html { redirect_to @active_period, notice: "Active period was successfully created." }
        format.json { render :show, status: :created, location: @working_period }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @active_period.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  
    def active_period_params
      params.require(:active_period).permit(:start_at, :end_at, :name, :department_id)
    end

end
