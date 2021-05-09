class AppointmentsController < ApplicationController
  before_action :authorized, only: [:create]

  def index
    render json: Appointment.in_future.order(:start_date).all
  end

  def create
    @appointment = Appointment.new(appointment_params)
    @appointment.student = @student
    if @appointment.save
      render json: { appointment: @appointment }, status: :created
    else
      render json: { error: @appointment.errors }, status: :unprocessable_entity
    end
  end

  private

  def appointment_params
    params.permit(:mentor_id, :start_date, :call_reason)
  end

end
