class MentorsController < ApplicationController
  before_action :authorized, only: []

  def index
    render json: { mentors: Mentor.all }
  end

  def create
    @mentor = Mentor.new(mentor_params)
    if @mentor.save
      render json: { mentor: @mentor }
    else
      render json: { error: @mentor.errors }
    end
  end

  private

  def mentor_params
    params.permit(:first_name, :last_name)
  end

end
