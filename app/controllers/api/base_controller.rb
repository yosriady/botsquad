class API::BaseController < ActionController::API
  before_action :authenticate
  before_action :validate_content_type

  # Possible Errors
  class UnauthorizedError < StandardError; end
  class BadRequestError < StandardError; end
  class InvalidContentTypeError < StandardError; end
  class NotFoundError < StandardError; end
  class ForbiddenError < StandardError; end
  class UnprocessableEntityError < StandardError; end

  # Error Handling
  rescue_from UnauthorizedError, with: :unauthorized
  rescue_from BadRequestError, with: :bad_request
  rescue_from ForbiddenError, with: :forbidden
  rescue_from InvalidContentTypeError, with: :invalid_content_type
  rescue_from NotFoundError, with: :not_found
  rescue_from UnprocessableEntityError, with: :unprocessable_entity

  # API Root
  def index
    render json: {
      'agents': api_v1_agents_url,
      'agent-types': api_v1_agent_types_url
    }
  end

  private

  def authenticate
    api_key = request.headers['X-Api-Key']
    @user = User.where(api_key: api_key).first if api_key

    fail UnauthorizedError, 'API Key Not Found' unless api_key && @user
  end

  def validate_content_type
    invalid = (request.headers['Content-Type'] &&
               request.headers['Content-Type'] != 'application/json')
    fail InvalidContentTypeError,
         'Only the application/json Content Type is available' if invalid
  end

  def unauthorized(e)
    render json: { error: 'unauthorized',
                   message: e.message,
                   url: 'http://botsquad.io/docs/errors' },
           status: :unauthorized
  end

  def bad_request(e)
    render json: { error: 'bad_request',
                   message: e.message,
                   url: 'http://botsquad.io/docs/errors#400' },
           status: 400
  end

  def forbidden(e)
    # Request failed because user does not have authorization to access a specific resource
    render json: { error: 'forbidden',
                   message: e.message,
                   url: 'http://botsquad.io/docs/errors#403' },
           status: 403
  end

  def not_found(e)
    render json: { error: 'not_found',
                   message: e.message,
                   url: 'http://botsquad.io/docs/errors#404' },
           status: 404
  end

  def invalid_content_type(e)
    render json: { error: 'invalid_content_type',
                   message: e.message,
                   url: 'http://botsquad.io/docs/errors#415' },
           status: 404
  end

  def unprocessable_entity(e)
    render json: { error: 'unprocessable_entity',
                   message: e.message,
                   url: 'http://botsquad.io/docs/errors#422' },
           status: 422
  end
end
