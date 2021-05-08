class Appointment < ApplicationRecord

  validate :check_availability
  validates :student_id, presence: true
  validates :mentor_id, presence: true
  validates :start_date, presence: true

  belongs_to :student
  belongs_to :mentor

  private

  def check_availability
    is_available = Appointment.where(start_date: start_date.beginning_of_hour..start_date.end_of_hour).first.nil?
    errors.add(:start_date, 'selected date already taken') unless is_available
  end

end
