class AppointmentsController < ApplicationController
  before_action :authorized_as_student, only: [:create]

  def index
    if params[:lower_bound] && params[:upper_bound]
      lower_bound = params[:lower_bound]
      upper_bound = params[:upper_bound]
      render json: Appointment.between_dates(lower_bound, upper_bound) and return
    end
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
    params.require(:appointment).permit(:mentor_id, :start_date, :call_reason)
  end

end
