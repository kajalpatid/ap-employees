module Api::V1
  class EmployeeDetailsController < Api::V1::BaseController
    before_action :position_type_check, only: %w[company_hierarchy]
    before_action :set_employee, only: %w[resign update]

    def index
      @employees    = Employee.all
      employee_type = Employee::TYPES[params[:type]]
      @employees    = @employees.where(type: employee_type) if employee_type
      render json: @employees
    end

    def create
      @employee = Employee.new(employees_params)
      response_error(@employee.errors.full_messages) unless @employee.save
    end

    def top_salary_employees
      @employees = Employee.top_salary_employees
    end

    def company_hierarchy
      @employees_hierarchy = CompanyHierarchy.new(params[:position_type]).run
    end

    def resign
      @employee.resign_employee
      render :create
    end

    def update
      return render :create if @employee.update(employees_params)
      response_error(@employee.errors.full_messages)
    end

    private

    def position_type_check
      invalid_position_type = params[:position_type].present? && Employee::TYPES.keys.include?(params[:position_type])
      response_error('Valid position_type must be present') unless invalid_position_type
    end

    def set_employee
      @employee = Employee.find_by(id: params[:id])
    end

    def employees_params
      params.require(:employee).permit(:id, :name, :salary, :rating, :type, :reporter_id, :resigned)
    end
  end
end
