require 'swagger_helper'

RSpec.describe MentorsController do

  fixtures :mentors, :students, :appointments

  describe 'GET /mentors' do
    it 'access array response' do
      get '/mentors'
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)).to be_an_instance_of(Array)
      expect(JSON.parse(response.body).size).to eq(Mentor.count)
    end
  end

  describe 'POST /mentors and POST/member-login' do
    it 'should return new created mentor and token and after that, it should login' do
      post '/mentors', params: { first_name: 'foo', last_name: 'bar', email: 'foo@bar.com', password: 'password' }
      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body)).to have_key('mentor')
      expect(JSON.parse(response.body)).to have_key('token')

      post '/mentor-login', params: { email: 'foo@bar.com', password: 'password' }
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)).to have_key('mentor')
      expect(JSON.parse(response.body)).to have_key('token')

      token = JSON.parse(response.body)['token']

      get '/mentors/me', headers: { Authorization: "Bearer #{token}" }
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)).to have_key('first_name')
      expect(JSON.parse(response.body)).to have_key('last_name')
      expect(JSON.parse(response.body)).to have_key('email')
      expect(JSON.parse(response.body)).to have_key('time_zone')

    end


    describe 'GET /mentors/:id/agenda' do
      it 'access mentor agenda' do
        mentor = mentors(:mentor_1)
        get "/mentors/#{mentor.id}/agenda"
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body).size).to eq(mentor.appointments.size)
      end
    end

    describe 'GET /mentors/:id' do
      it 'access mentor data' do
        mentor = mentors(:mentor_1)
        get "/mentors/#{mentor.id}"
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)).to have_key('first_name')
        expect(JSON.parse(response.body)).to have_key('last_name')
        expect(JSON.parse(response.body)).to have_key('email')
        expect(JSON.parse(response.body)).to have_key('time_zone')
      end
    end

  end


end
