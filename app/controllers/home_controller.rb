class HomeController < ActionController::API

  def index
    render json: { version: '1.0.0', 'description': 'Student - mentor appointment API', swagger: '/api-docs' }
  end

end
