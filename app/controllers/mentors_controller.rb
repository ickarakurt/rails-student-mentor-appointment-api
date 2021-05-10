class MentorsController < ApplicationController
  before_action :authorized_as_mentor, only: [:me]

  def index
    render json: Mentor.all
  end

  def create
    @mentor = Mentor.new(mentor_params)
    if @mentor.save
      token = encode_token({ mentor_id: @mentor.id })
      render json: { mentor: @mentor, token: token }, status: :created
    else
      render json: { error: @mentor.errors }, status: :unprocessable_entity
    end
  end

  def login
    @mentor = Mentor.find_by(email: params[:email])

    if @mentor&.authenticate(params[:password])
      token = encode_token({ mentor_id: @mentor.id })
      render json: { mentor: @mentor, token: token }, status: :ok
    else
      render json: { error: 'Invalid email or password' }
    end
  end

  def me
    render json: @mentor
  end

  def agenda
    render json: Mentor.find(params[:id])&.appointments
  end

  def mentor
    render json: Mentor.find(params[:id])
  end

  private

  def mentor_params
    params.require(:mentor).permit(:email, :password, :first_name, :last_name, :time_zone)
  end

end
