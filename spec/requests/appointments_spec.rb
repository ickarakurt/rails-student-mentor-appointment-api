require 'swagger_helper'

RSpec.describe AppointmentsController do

  fixtures :mentors, :students, :appointments

  describe 'GET /appointments' do
    it 'access array response' do
      get '/appointments'
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)).to be_an_instance_of(Array)
      expect(JSON.parse(response.body).size).to eq(Appointment.count)
    end
  end

  describe 'POST /appointments' do
    it 'should return new created appointments' do
      student = students(:student_1)
      mentor = mentors(:mentor_1)
      post '/appointments', params: { student_id: student.id, mentor_id: mentor.id, start_date: Time.now, call_reason: 'sample reason' }
      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body)).to have_key('appointment')
    end

  end

end
