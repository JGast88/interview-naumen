class DashboardController < ApplicationController
  def index
    @date = params[:date] || Date.today
    @departments = Department.roots(@date)
    @department = Department.find_by(id: params[:department])
    @people = if @department
      @department.people_working_on_date(@date)
    else
      Person.all
    end
  end
end
