class ApplicationController < ActionController::API
  before_action :authorized
  rescue_from ActiveRecord::RecordNotFound, with: :not_found_error

  def self.encode_token(payload)
    JWT.encode(payload, 'cf_s3cr3t')
  end

  def encode_token(payload)
    JWT.encode(payload, 'cf_s3cr3t')
  end

  def auth_header
    request.headers['Authorization']
  end

  def decoded_token
    if auth_header
      token = auth_header.split(' ')[1]
      begin
        JWT.decode(token, 'cf_s3cr3t', true, algorithm: 'HS256')
      rescue JWT::DecodeError
        nil
      end
    end
  end

  def authorized
    if decoded_token
      mentor_id = decoded_token[0]['mentor_id']
      if mentor_id
        @mentor = Mentor.find_by(id: mentor_id)
      else
        student_id = decoded_token[0]['student_id']
        @student = Student.find_by(id: student_id)
      end
    end
    unauthorized if @student.nil? && @mentor.nil?
  end

  def authorized_as_student
    !@student.nil? || unauthorized
  end

  def authorized_as_mentor
    !@mentor.nil? || unauthorized
  end

  def unauthorized
    render json: { message: 'Please log in' }, status: :unauthorized
  end

  def not_found_error
    render json: { error: "Record not found." }, status: :not_found
  end

end
