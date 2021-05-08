class Mentor < ApplicationRecord

  validates :first_name, presence: true
  validates_length_of :first_name, minimum: 2, too_short: ' is too short(minimum is 2 characters)'

  validates :last_name, presence: true
  validates_length_of :last_name, minimum: 2, too_short: ' is too short(minimum is 2 characters)'

end
