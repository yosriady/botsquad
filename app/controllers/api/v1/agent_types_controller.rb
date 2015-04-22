class API::V1::AgentTypesController < API::BaseController
  before_action :set_agent_type, only: [:show]
  # GET /agent-types
  def index
    @agent_types = AgentType.page(params[:page])
    render json: @agent_types
  end

  # GET /agent-types/:slug
  def show
    render json: @agent_type
  end

  private
    def set_agent_type
      @agent_type = AgentType.find(params[:id])
    end
end
