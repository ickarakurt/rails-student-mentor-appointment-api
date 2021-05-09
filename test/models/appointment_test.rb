require 'test_helper'

class AppointmentTest < ActiveSupport::TestCase

  test 'appointment with correct data should be valid' do
    appointment = Appointment.new
    appointment.student = students(:student_1)
    appointment.mentor = mentors(:mentor_1)
    appointment.start_date = Time.now
    assert appointment.valid?
  end

  test 'appointment with null student should not be valid' do
    appointment = Appointment.new
    appointment.mentor = mentors(:mentor_1)
    appointment.start_date = Time.now
    appointment.valid?
    assert_not appointment.errors[:student].empty?
  end

  test 'appointment with null mentor should not be valid' do
    appointment = Appointment.new
    appointment.student = students(:student_1)
    appointment.start_date = Time.now
    appointment.valid?
    assert_not appointment.errors[:mentor].empty?
  end

  test 'appointment with null start_date should not be valid' do
    appointment = Appointment.new
    appointment.student = students(:student_1)
    appointment.mentor = mentors(:mentor_1)
    appointment.valid?
    assert_not appointment.errors[:start_date].empty?
  end

  test 'appointment should not created if hour is not available' do
    appointment = appointments(:appointment_1)
    appointment.start_date = (Time.now + 6.days).beginning_of_hour + 3.minutes
    appointment.save

    appointment2 = appointments(:appointment_2)
    appointment2.start_date = (Time.now + 6.days).beginning_of_hour + 50.minutes

    appointment2.valid?
    assert_not appointment2.errors[:start_date].empty?
  end


  test 'appointment should created if hour is available' do
    appointment = appointments(:appointment_1)
    appointment.start_date = (Time.now + 6.days).beginning_of_hour + 10.minutes
    appointment.save

    appointment2 = appointments(:appointment_2)
    appointment2.start_date = (Time.now + 6.days).beginning_of_hour + 1.hour
    assert appointment2.valid?
  end

  test 'appointment should not created if student is not available' do
    appointment = appointments(:appointment_2)
    appointment.start_date = (Time.now + 6.days).beginning_of_hour + 10.minutes
    appointment.save

    appointment2 = appointments(:appointment_3)
    appointment2.start_date = (Time.now + 6.days).beginning_of_hour + 17.minutes

    appointment2.valid?
    assert_not appointment2.errors[:start_date].empty?
  end

  test 'appointment with past date should not be valid' do
    appointment = Appointment.new
    appointment.student = students(:student_1)
    appointment.mentor = mentors(:mentor_1)
    appointment.start_date = Time.now - 5.days
    appointment.valid?
    assert_not appointment.errors[:start_date].empty?
  end

end
