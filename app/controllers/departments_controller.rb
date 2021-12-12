class DepartmentsController < ApplicationController
  before_action :set_department, only: %i[ show edit update destroy new_name set_name new_parent set_parent ]

  def new_name
  end

  def set_name
    date = params[:changed_at]
    current_ap = @department.current_active_period(date)

    if current_ap
      new_ap = @department.active_periods.new(
        start_at: params[:changed_at],
        end_at: current_ap.end_at,
        parent_id: @department.parent_id(params[:changed_at]),
        name: params[:name]
      )
      current_ap.end_at = date

      ActiveRecord::Base.transaction do
        current_ap.save!
        new_ap.save!
      end
    else
      raise 'Date should be whithin department active period'
    end
    
    redirect_to @department
  end

  def new_parent
    @departments = Department.all
  end

  def set_parent
    date = params[:changed_at]
    current_ap = @department.current_active_period(date)
    if current_ap
      new_ap = @department.active_periods.new(
        start_at: params[:changed_at],
        end_at: current_ap.end_at,
        parent_id: params[:parent_id],
        name: @department.name_on_date(params[:changed_at]) #Department.find(params[:parent_id]).name_on_date(params[:changed_at])
      )
      current_ap.end_at = date

      ActiveRecord::Base.transaction do
        current_ap.save!
        new_ap.save!
      end
    else
      raise 'Date should be whithin department active period'
    end

    redirect_to @department
  end

  # GET /departments or /departments.json
  def index
    @departments = Department.all
  end

  # GET /departments/1 or /departments/1.json
  def show
    @people = Person.all
    @departments = Department.all
  end

  # GET /departments/new
  def new
    @department = Department.new
  end

  # GET /departments/1/edit
  def edit
  end

  # POST /departments or /departments.json
  def create
    @department = Department.new(department_params)

    ActiveRecord::Base.transaction do
      respond_to do |format|
        if @department.save! 
          active_period = @department.active_periods.new(
            name: department_params[:name],
            start_at: @department.created_at,
            end_at: department_params[:disbanded_at]
          )
          active_period.save!
          format.html { redirect_to @department, notice: "Department was successfully created." }
          format.json { render :show, status: :created, location: @department }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @department.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /departments/1 or /departments/1.json
  def update
    respond_to do |format|
      if @department.update(department_params)
        format.html { redirect_to @department, notice: "Department was successfully updated." }
        format.json { render :show, status: :ok, location: @department }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @department.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /departments/1 or /departments/1.json
  def destroy
    @department.destroy
    respond_to do |format|
      format.html { redirect_to departments_url, notice: "Department was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_department
      @department = Department.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def department_params
      params.require(:department).permit(:created_at, :disbanded_at, :name, :parent_id)
    end
end
