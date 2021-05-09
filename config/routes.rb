Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resource :students, only: %i[create]
  resource :mentors, only: %i[create]
  resource :appointments, only: %i[create]

  get '/', to: 'home#index'

  get '/students', to: 'students#index'
  get '/students/me', to: 'students#me'
  get '/students/:id', to: 'students#student'
  get '/students/:id/appointments', to: 'students#appointments'
  get '/mentors', to: 'mentors#index'
  get '/mentors/me', to: 'mentors#me'
  get '/mentors/:id', to: 'mentors#mentor'
  get '/mentors/:id/agenda', to: 'mentors#agenda'
  post '/mentor-login', to: 'mentors#login'
  get '/appointments', to: 'appointments#index'
  post '/login', to: 'students#login'
end