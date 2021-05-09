class StudentsController < ApplicationController
  before_action :authorized_as_student, only: [:me]

  def index
    render json: Student.all
  end

  def create
    @student = Student.new(student_params)
    if @student.save
      token = encode_token({ student_id: @student.id })
      render json: { student: @student, token: token }, status: :created
    else
      render json: { error: @student.errors }, status: :unprocessable_entity
    end
  end

  def login
    @student = Student.find_by(email: params[:email])

    if @student&.authenticate(params[:password])
      token = encode_token({ student_id: @student.id })
      render json: { student: @student, token: token }, status: :ok
    else
      render json: { error: 'Invalid email or password' }
    end
  end

  def me
    render json: @student
  end

  def appointments
    render json: Student.find(params[:id])&.appointments
  end

  def student
    render json: Student.find(params[:id])
  end

  private

  def student_params
    params.permit(:email, :password, :first_name, :last_name, :time_zone)
  end

end
