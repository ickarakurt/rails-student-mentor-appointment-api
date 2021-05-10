class ApplicationController < ActionController::API

  rescue_from ActiveRecord::RecordNotFound, with: :not_found_error

  def self.encode_token(payload)
    JWT.encode(payload, ENV['JWT_SECRET'])
  end

  def encode_token(payload)
    JWT.encode(payload, ENV['JWT_SECRET'])
  end

  def auth_header
    request.headers['Authorization']
  end

  def decoded_token
    if auth_header
      token = auth_header.split(' ')[1]
      begin
        JWT.decode(token, ENV['JWT_SECRET'], true, algorithm: 'HS256')
      rescue JWT::DecodeError
        nil
      end
    end
  end

  def authorized_as_student
    if decoded_token
      student_id = decoded_token[0]['student_id']
      @student = Student.find_by(id: student_id)
    end
    unauthorized if @student.nil?
  end

  def authorized_as_mentor
    if decoded_token
      mentor_id = decoded_token[0]['mentor_id']
      @mentor = Mentor.find_by(id: mentor_id)
    end
    unauthorized if @mentor.nil?
  end

  def unauthorized
    render json: { message: 'Please log in' }, status: :unauthorized
  end

  def not_found_error
    render json: { error: 'Record not found.' }, status: :not_found
  end

end
