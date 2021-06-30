class Manager < Employee
  has_many :reportees, class_name: 'Employee', foreign_key: :reporter_id
  has_one :reporter, class_name: 'Employee', foreign_key: :id, primary_key: :reporter_id

  MANAGER_REPORTERS = %w(ChiefExecutiveOfficer VicePresident Director)

  validate :valid_reporter

  def valid_reporter
    return if reporter_id.blank?
    unless MANAGER_REPORTERS.include?(reporter.type)
      errors.add(:reporter, 'Must be valid reporter')
    end
  end
end
