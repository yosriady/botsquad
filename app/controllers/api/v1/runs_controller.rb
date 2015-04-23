class API::V1::RunsController < API::BaseController
  before_action :set_agent
  before_action :set_run, only: [:show]
  before_action :authenticate

  # GET /runs
  def index
    @runs = Run.page(params[:page])
    render json: @runs
  end

  # GET /runs/1
  def show
    render json: @run
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_run
      @run = Run.find(params[:id])
    end

    def set_agent
      @agent = Agent.friendly.find(params[:id])
    end
end
