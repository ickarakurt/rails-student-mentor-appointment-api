require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource 'Students' do

  header 'Accept', 'application/json'
  header 'Content-Type', 'application/json'

  get '/students' do
    example 'Listing students' do
      do_request
      expect(status).to eq 200
    end
  end
end
