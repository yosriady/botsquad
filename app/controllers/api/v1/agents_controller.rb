class API::V1::AgentsController < API::BaseController
  before_action :set_agent, only: [:show, :webhooks, :runs, :update, :destroy]

  # GET /agents
  def index
    @agents = @user.agents.page(params[:page])
    render json: @agents, root: :agents
  end

  # GET /agents/1
  def show
    render json: @agent
  end

  # GET /agents/1/webhooks
  def webhooks
    @webhooks = @agent.webhooks
    render json: @webhooks, root: :webhooks
  end

  # GET /agents/1/runs
  def runs
    @runs = @agent.runs
    render json: @runs, root: :runs
  end

  # POST /agents
  def create
    @agent = @user.agents.new(agent_params)
    @agent.agent_type = AgentType.find_by(slug: params[:agent_type])

    if @agent.save
      render json: @agent, status: 200, notice: 'Agent was successfully updated.'
    else
      render status: 422
    end
  end

  # PATCH/PUT /agents/1
  def update
    if @agent.update(agent_params)
      render json: @agent, status: 200, notice: 'Agent was successfully updated.'
    else
      render status: 422
    end
  end

  # DELETE /agents/1
  def destroy
    if @agent.destroy
      render json: @agent, status: 200, notice: 'Agent was successfully destroyed.'
    else
      render status: 422
    end
  end

  private
    def set_agent
      @agent = Agent.friendly.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def agent_params
      params.permit(:interval, :slug, :user_id,
                    :payload, :description, :name)
    end
end
