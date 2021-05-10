require 'swagger_helper'

RSpec.describe AppointmentsController do

  fixtures :mentors, :students, :appointments

  describe 'GET /appointments' do
    it 'access array response' do
      get '/appointments'
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)).to be_an_instance_of(Array)
      expect(JSON.parse(response.body).size).to eq(Appointment.in_future.count)
    end
  end

  describe 'GET /appointments with date params' do
    it 'access array response between x and y dates' do
      get '/appointments', params: { lower_bound: Time.now - 20.days, upper_bound: Time.now + 20.days }
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)).to be_an_instance_of(Array)
      expect(JSON.parse(response.body).size).to eq(Appointment.between_dates(Time.now - 20.days, Time.now + 20.days).count)
    end
  end

  describe 'POST /appointments' do
    it 'should return new created appointments' do
      student = students(:student_1)
      token = ApplicationController.encode_token({ student_id: student.id })
      mentor = mentors(:mentor_1)
      params = { appointment: { student_id: student.id, mentor_id: mentor.id, start_date: Time.now, call_reason: 'sample reason' } }
      post '/appointments', params: params, headers: { Authorization: "Bearer #{token}" }
      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body)).to have_key('appointment')
    end

  end

end
