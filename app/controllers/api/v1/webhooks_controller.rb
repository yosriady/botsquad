class API::V1::WebhooksController < API::BaseController
  before_action :set_agent, only: [:index, :create]
  before_action :set_webhook, only: [:show, :agents, :events, :destroy]

  # GET /webhooks
  def index
    render json: @agent.webhooks, root: :webhooks
  end

  # GET /webhooks/1
  def show
    render json: @webhook
  end

  # GET /webhooks/1/agents
  def agents
    @agents = @webhook.agents
    render json: @agents, root: :agents
  end

  # GET /webhooks/1/events
  def events
    @events = @webhook.events
    render json: @events, root: :events
  end

  # POST /webhooks
  def create
    @webhook = Webhook.find_or_initialize_by(webhook_params.except(:id))
    @webhook.agents << @agent

    if @webhook.save
      render json: @webhook, status: 200,
             notice: 'Webhook was successfully updated.'
    else
      fail UnprocessableEntityError, @webhook.errors.full_messages.to_sentence
    end
  end

  # DELETE /webhooks/1
  def destroy
    if @webhook.destroy
      render json: @webhook, status: 200,
             notice: 'Webhook was successfully destroyed.'
    else
      fail UnprocessableEntityError, @webhook.errors.full_messages.to_sentence
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_webhook
      @webhook = Webhook.find(params[:id])
    end

    def set_agent
      @agent = Agent.find_by(slug: params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def webhook_params
      params.permit(:id, :url)
    end
end
