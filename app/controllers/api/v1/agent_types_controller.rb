class API::V1::AgentTypesController < API::BaseController
  before_action :set_agent_type, only: [:show]

  # GET /agent-types
  def index
    @agent_types = AgentType.page(params[:page]).per(params[:per_page])
    render json: @agent_types, root: 'agent-types'
  end

  # GET /agent-types/:slug
  def show
    render json: @agent_type
  end

  private
    def set_agent_type
      @agent_type = AgentType.friendly.find(params[:id])
      fail NotFoundError, 'Agent Type Not Found' unless @agent_type
    end
end
