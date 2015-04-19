class API::BaseController < ApplicationController
  protect_from_forgery with: :null_session

  private

  def authenticate
    authenticate_or_request_with_http_token do |token, options|
      @user = User.where(api_key: token).first
    end
  end
end