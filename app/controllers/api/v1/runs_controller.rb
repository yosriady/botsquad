class API::V1::RunsController < API::BaseController
  before_action :set_run

  # GET /runs/1
  def show
    render json: @run
  end

  # GET /runs/1/events
  def events
    render json: @run.events, root: :events
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_run
    @run = Run.find(params[:id])
    fail NotFoundError, 'Run Not Found' unless @run
  end

  def set_agent
    @agent = Agent.find_by(slug: params[:id])
    fail NotFoundError, 'Agent Not Found' unless @agent
  end
end
