require 'swagger_helper'

RSpec.describe StudentsController do

  fixtures :mentors, :students, :appointments

  describe 'GET /students' do
    it 'access array response' do
      get '/students'
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)).to be_an_instance_of(Array)
      expect(JSON.parse(response.body).size).to eq(Student.count)
    end
  end

  describe 'POST /student and POST/login' do
    it 'should return new created student and token and after that, it should login' do
      post '/students', params: { first_name: 'foo', last_name: 'bar', email: 'foo@bar.com', password: 'password' }
      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body)).to have_key('student')
      expect(JSON.parse(response.body)).to have_key('token')

      post '/login', params: { email: 'foo@bar.com', password: 'password' }
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)).to have_key('student')
      expect(JSON.parse(response.body)).to have_key('token')

      token = JSON.parse(response.body)['token']

      get '/students/me', headers: { Authorization: "Bearer #{token}" }
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)).to have_key('first_name')
      expect(JSON.parse(response.body)).to have_key('last_name')
      expect(JSON.parse(response.body)).to have_key('email')
      expect(JSON.parse(response.body)).to have_key('time_zone')

    end


    describe 'GET /students/:id/appointments' do
      it 'access student appointments' do
        student = students(:student_1)
        get "/students/#{student.id}/appointments"
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body).size).to eq(student.appointments.size)
      end
    end

    describe 'GET /students/:id' do
      it 'access student data' do
        student = students(:student_1)
        get "/students/#{student.id}"
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)).to have_key('first_name')
        expect(JSON.parse(response.body)).to have_key('last_name')
        expect(JSON.parse(response.body)).to have_key('email')
        expect(JSON.parse(response.body)).to have_key('time_zone')
      end
    end

  end


end
