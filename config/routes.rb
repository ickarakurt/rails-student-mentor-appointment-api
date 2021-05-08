Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  mount Raddocs::App => "/docs"

  resource :students, only: %i[create]
  resource :mentors, only: %i[create]
  resource :appointments, only: %i[create]

  get '/students', to: 'students#index'
  get '/mentors', to: 'mentors#index'
  get '/appointments', to: 'appointments#index'
  post '/login', to: 'students#login'
end