# fetch company Hierarchy
class CompanyHierarchy
  attr_reader :position_type, :employee_types, :top_employees

  def initialize(position_type)
    @employee_types   = Employee::TYPES
    @position_type    = @employee_types[position_type]
  end

  def run
    @top_employees = find_top_employees
    bottom_employees.map do |bottom_employee|
      [bottom_employee.name] + top_level(bottom_employee)
    end
  end

  private

  def top_level(bottom_employee)
    reporter_id = bottom_employee.reporter_id
    top_employees.map do |top_employee|
      if top_employee.id == reporter_id
        reporter_id = top_employee.reporter_id
        top_employee.name
      end
    end.compact
  end

  def bottom_employees
    Employee.where(type: position_type, resigned: false)
  end

  def find_top_employees
    position_types = top_position_types
    return Employee.none if position_types.empty?

    order_by = ['case']
    order_by += position_types.map.with_index{ |type, index| "when type = '#{type}' then #{index}" }
    order_by << ['end']
    Employee.where(type: position_types, resigned: false).order(Arel.sql(order_by.join(' ')))
  end

  def top_position_types
    employee_values = employee_types.values
    employee_values[0...(employee_values.find_index(position_type))].reverse
  end
end
