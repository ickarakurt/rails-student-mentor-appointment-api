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
    assert_not appointment.errors[:student_id].empty?
  end

  test 'appointment with null mentor should not be valid' do
    appointment = Appointment.new
    appointment.student = students(:student_1)
    appointment.start_date = Time.now
    appointment.valid?
    assert_not appointment.errors[:mentor_id].empty?
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
    appointment.start_date = '2021-05-08 13:16:39.133874'
    appointment.save

    appointment2 = appointments(:appointment_2)
    appointment2.start_date = '2021-05-08 13:50:39.133874'

    appointment2.valid?
    assert_not appointment2.errors[:start_date].empty?
  end


  test 'appointment should created if hour is available' do
    appointment = appointments(:appointment_1)
    appointment.start_date = '2021-05-08 13:16:39.133874'
    appointment.save

    appointment2 = appointments(:appointment_2)
    appointment2.start_date = '2021-05-08 14:00:00.133874'

    assert appointment2.valid?
  end

  test 'appointment should not created if student is not available' do
    appointment = appointments(:appointment_2)
    appointment.start_date = '2021-05-08 17:16:39.133874'
    appointment.save

    appointment2 = appointments(:appointment_3)
    appointment2.start_date = '2021-05-08 17:50:00.133874'

    appointment2.valid?
    assert_not appointment2.errors[:start_date].empty?
  end

end
