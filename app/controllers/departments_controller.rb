class DepartmentsController < ApplicationController
  before_action :set_department, only: %i[ show edit update destroy new_name set_name new_parent set_parent ]

  def new_name
  end

  def set_name
    @department.name = params[:name]
    date = params[:changed_at]
    
    # TODO
    # end current active period
    last_active_period = @department.active_periods.last
    last_active_period.end_at = date
    # start new active period
    current_active_period = @department.active_periods.new(
      start_at: date,
      department_name: params[:name]
    )

    text = 'Failed'
    ActiveRecord::Base.transaction do
      if @department.save!
        if last_active_period.save!
          if current_active_period.save!
            text = 'Success'
          end
        end
      end
    end
    
    redirect_to @department, notice: text
  end

  def new_parent
    @departments = Department.all
  end

  def set_parent
    @department.parent_id = params[:parent_id]

    # end current active period
    last_active_period = @department.active_periods.last
    last_active_period.end_at = params[:changed_at]
    # start new active period
    current_active_period = @department.active_periods.new(
      start_at: params[:changed_at],
      department_name: @department.name,
      parent_department_name: @department.parent&.name,
    )

    ActiveRecord::Base.transaction do
      @department.save
      last_active_period.save
      current_active_period.save
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
            start_at: @department.created_at,
            department_name: @department.name,
            parent_department_name: @department.parent&.name
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
