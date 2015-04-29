class API::V1::AgentsController < API::BaseController
  before_action :set_agent, only: [:show, :webhooks, :runs, :update, :destroy]

  # GET /agents
  def index
    @agents = @user.agents.page(params[:page]).per(params[:per_page])
    render json: @agents, root: :agents
  end

  # GET /agents/1
  def show
    render json: @agent
  end

  # GET /agents/1/webhooks
  def webhooks
    @webhooks = @agent.webhooks.page(params[:page]).per(params[:per_page])
    render json: @webhooks, root: :webhooks
  end

  # GET /agents/1/runs
  def runs
    @runs = @agent.runs.page(params[:page]).per(params[:per_page])
    render json: @runs, root: :runs
  end

  # POST /agents
  def create
    agent_params[:user_id] = @user.id
    @agent = @user.agents.new(agent_params.except('agent-type'))
    @agent.agent_type = AgentType.find_by(slug: agent_params['agent-type'])

    if @agent.save
      render json: @agent, status: 201
    else
      binding.pry
      fail UnprocessableEntityError, @agent.errors.full_messages.to_sentence
    end
  end

  # PATCH/PUT /agents/1
  def update
    if @agent.update(agent_params)
      render json: @agent, status: 200
    else
      fail UnprocessableEntityError, @agent.errors.full_messages.to_sentence
    end
  end

  # DELETE /agents/1
  def destroy
    if @agent.destroy
      render json: @agent, status: 200
    else
      fail UnprocessableEntityError, @agent.errors.full_messages.to_sentence
    end
  end

  private

  def set_agent
    @agent = Agent.find_by(slug: agent_params[:id])
    fail NotFoundError, 'Agent Not Found' unless @agent
  end

  # Only allow a trusted parameter "white list" through.
  def agent_params
    params.permit(:id, :payload, :description, :name, :interval, 'agent-type')
  end
end
