class PageController < ApplicationController

  def index
  end

  def signup
    @signup = Signup.find_or_initialize_by(signup_params)
    if @signup.save
      render json: @signup, status: 200, notice: 'Signup submitted.'
    else
      render status: 422
    end
  end

  private
    def signup_params
      params.permit(:email)
    end
end
