class Appointment < ApplicationRecord

  validates :student_id, presence: true
  validates :mentor_id, presence: true
  validates :start_date, presence: true
  validate :check_availability, if: :start_date

  belongs_to :student
  belongs_to :mentor

  private

  def mentor_available?
    Appointment.where(mentor_id: mentor_id, start_date: start_date.beginning_of_hour..start_date.end_of_hour).first.nil?
  end

  def student_available?
    Appointment.where(student_id: student_id, start_date: start_date.beginning_of_hour..start_date.end_of_hour).first.nil?
  end

  def check_availability
    errors.add(:start_date, 'mentor is not available on selected date') unless mentor_available?
    errors.add(:start_date, 'student is not available on selected date') unless student_available?
  end

end
