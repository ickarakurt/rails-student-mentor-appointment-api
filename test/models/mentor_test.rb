require 'test_helper'

class MentorTest < ActiveSupport::TestCase

  test 'mentor with correct data should be valid' do
    mentor = Mentor.new
    mentor.first_name = 'FirstName'
    mentor.last_name = 'Surname'
    mentor.email = 'test@example.com'
    mentor.password = 'test_password'
    assert mentor.valid?
  end

  test 'mentor with null first_name should not be valid' do
    mentor = Mentor.new
    mentor.last_name = 'Surname'
    mentor.email = 'test@example.com'
    mentor.password = 'test_password'
    mentor.valid?
    assert_not mentor.errors[:first_name].empty?
  end

  test 'mentor with null last_name should not be valid' do
    mentor = Mentor.new
    mentor.first_name = 'FirstName'
    mentor.email = 'test@example.com'
    mentor.password = 'test_password'
    mentor.valid?
    assert_not mentor.errors[:last_name].empty?
  end

  test 'mentor with null email should not be valid' do
    mentor = Mentor.new
    mentor.first_name = 'FirstName'
    mentor.last_name = 'Surname'
    mentor.password = 'test_password'
    mentor.valid?
    assert_not mentor.errors[:email].empty?
  end

  test 'mentor with invalid email should not be valid' do
    mentor = Mentor.new
    mentor.first_name = 'FirstName'
    mentor.last_name = 'Surname'
    mentor.email = 'example.com'
    mentor.password = 'test_password'
    mentor.valid?
    assert_not mentor.errors[:email].empty?
  end

  test 'mentor with null password should not be valid' do
    mentor = Mentor.new
    mentor.first_name = 'FirstName'
    mentor.last_name = 'Surname'
    mentor.email = 'example.com'
    mentor.valid?
    assert_not mentor.errors[:password].empty?
  end


end
