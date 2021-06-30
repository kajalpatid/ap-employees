class Employee < ApplicationRecord

  validates :name, :salary, :type, presence: true
  validates :name, uniqueness: true
  validates :type, inclusion: { in: %w(ChiefExecutiveOfficer VicePresident Director Manager SoftwareDevelopmentEngineer) }

  TYPES = { 'ceo' => 'ChiefExecutiveOfficer',
            'vp' => 'VicePresident',
            'director' => 'Director',
            'manager' => 'Manager',
            'sde' => 'SoftwareDevelopmentEngineer' }.freeze

  scope :top_salary_employees, lambda {
    salary_ratio = '(salary)/(select sum(salary) from employees)'
    query = "select name, ROUND((#{salary_ratio}), 4) as ratio from employees WHERE resigned = 0 ORDER BY ratio desc limit 10"
    ActiveRecord::Base.connection.execute(query)
  }

  def resign_employee
    return if !(update(resigned: true)) || reporter_id.blank? || type == 'SoftwareDevelopmentEngineer' || reportees.empty?
    reportees.update_all(reporter_id: reporter_id)
  end
end
