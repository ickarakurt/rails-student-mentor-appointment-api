class AppointmentsController < ApplicationController
  before_action :authorized, only: []

  def index
    render json: { appointments: Appointment.all }
  end

  def create
    @appointment = Appointment.new(appointment_params)
    if @appointment.save
      render json: { student: @appointment }
    else
      render json: { error: @appointment.errors }
    end
  end

  private

  def appointment_params
    params.permit(:mentor_id, :student_id, :start_date, :call_reason)
  end

end
