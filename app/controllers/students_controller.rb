class StudentsController < ApplicationController
  before_action :authorized, only: []

  def index
    render json: { students: Student.all }
  end

  # REGISTER
  def create
    @student = Student.new(student_params)
    if @student.save
      token = encode_token({ student_id: @student.id })
      render json: { student: @student, token: token }
    else
      render json: { error: @student.errors }
    end
  end

  def login
    @student = Student.find_by(email: params[:email])

    if @student&.authenticate(params[:password])
      token = encode_token({ student_id: @student.id })
      render json: { student: @student, token: token }
    else
      render json: { error: 'Invalid email or password' }
    end
  end

  private

  def student_params
    params.permit(:email, :password, :first_name, :last_name)
  end

end
