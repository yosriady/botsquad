class API::BaseController < ActionController::API
  before_action :authenticate

  # Possible Errors
  class APIKeyNotFoundError < StandardError; end

  # Error Handling
  rescue_from APIKeyNotFoundError, with: :api_key_not_found

  # API Root
  def index
    render json: {
      agents: api_v1_agents_url
    }
  end

  private

  def authenticate
    api_key = request.headers['Botsquad-Api-Key']
    @user = User.where(api_key: api_key).first if api_key

    fail APIKeyNotFoundError unless api_key && @user
  end

  def api_key_not_found
    render json: { message: 'API Key Not Found', information_link: 'http://botsquad.io/docs/errors' }, status: :unauthorized
  end
end
