class SoftwareDevelopmentEngineer < Employee
  has_one :reporter, class_name: 'Employee', foreign_key: :id, primary_key: :reporter_id
  SDE_REPORTERS = %w(ChiefExecutiveOfficer VicePresident Director Manager)
  validate :valid_reporter

  def valid_reporter
    return if reporter_id.blank?
    unless SDE_REPORTERS.include?(reporter.type)
      errors.add(:reporter, 'Must be valid reporter')
    end
  end
end
