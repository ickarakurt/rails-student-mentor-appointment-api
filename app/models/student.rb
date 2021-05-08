class Student < ApplicationRecord

  has_secure_password

  validates :first_name, presence: true
  validates_length_of :first_name, minimum: 2, too_short: ' is too short(minimum is 2 characters)'

  validates :last_name, presence: true
  validates_length_of :last_name, minimum: 2, too_short: ' is too short(minimum is 2 characters)'

  validates :email, presence: true, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  def as_json(options = {})
    super(options.merge({ except: %i[password password_digest] }))
  end

end
