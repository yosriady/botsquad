class API::V1::AgentsController < API::APIController
  before_action :set_agent, only: [:show, :edit, :update, :destroy]
  before_action :authenticate

  # GET /agents
  def index
    @agents = @user.agents.page(params[:page])
    render json: @agents
  end

  # GET /agents/1
  def show
    render json: @agent
  end

  # GET /agents/1/webhooks
  def webhooks
    @webhooks = @agent.webhooks
    render json: @webhooks
  end

  # GET /agents/1/runs
  def runs
    @runs = @agent.runs
    render json: @runs
  end

  # GET /agents/new
  def new
    @agent = @user.agents.new
  end

  # GET /agents/1/edit
  def edit
  end

  # POST /agents
  def create
    @agent = @user.agents.new(agent_params)

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
    # Use callbacks to share common setup or constraints between actions.
    def set_agent
      @agent = Agent.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def agent_params
      params.require(:agent).permit(:interval, :type, :user_id, :payload, :description, :name)
    end
end
