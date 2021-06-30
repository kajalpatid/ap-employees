class ChiefExecutiveOfficer < Employee
  has_many :reportees, class_name: 'Employee', foreign_key: :reporter_id

  validates :reporter_id, absence: true
  validate :cannot_resign

  def cannot_resign
    errors.add(:resigned, 'CEO cannot resign') if resigned && reportees.any?
  end

end
