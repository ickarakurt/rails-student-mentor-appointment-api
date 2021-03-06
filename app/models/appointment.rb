class Appointment < ApplicationRecord
  
  scope :in_future, -> { where('start_date > ?', Time.now) }


  validates :student, presence: true
  validates :mentor, presence: true
  validates :start_date, presence: true
  validate :check_start_date_is_in_future
  validate :check_availability, if: :start_date

  belongs_to :student
  belongs_to :mentor


  def self.between_dates(lower_date, upper_date)
    Appointment.where(start_date: lower_date..upper_date)
  end

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

  def check_start_date_is_in_future
    if start_date.present? && start_date < Date.today
      errors.add(:start_date, 'can\'t be in the past')
    end
  end

end
