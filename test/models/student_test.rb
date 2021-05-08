require 'test_helper'

class StudentTest < ActiveSupport::TestCase

  test 'student with correct data should be valid' do
    student = Student.new
    student.first_name = 'FirstName'
    student.last_name = 'Surname'
    student.password = 'test_password'
    student.email = 'test@example.com'
    assert student.valid?
  end

  test 'student with null first_name should not be valid' do
    student = Student.new
    student.last_name = 'Surname'
    student.email = 'test@example.com'
    student.password = 'test_password'
    student.valid?
    assert_not student.errors[:first_name].empty?
  end

  test 'student with null last_name should not be valid' do
    student = Student.new
    student.first_name = 'FirstName'
    student.email = 'test@example.com'
    student.password = 'test_password'
    student.valid?
    assert_not student.errors[:last_name].empty?
  end

  test 'student with null email should not be valid' do
    student = Student.new
    student.first_name = 'FirstName'
    student.last_name = 'Surname'
    student.password = 'test_password'
    student.valid?
    assert_not student.errors[:email].empty?
  end

  test 'student with invalid email should not be valid' do
    student = Student.new
    student.first_name = 'FirstName'
    student.last_name = 'Surname'
    student.email = 'example.com'
    student.password = 'test_password'
    student.valid?
    assert_not student.errors[:email].empty?
  end

  test 'student with null password should not be valid' do
    student = Student.new
    student.first_name = 'FirstName'
    student.last_name = 'Surname'
    student.email = 'example.com'
    student.valid?
    assert_not student.errors[:password].empty?
  end

end
