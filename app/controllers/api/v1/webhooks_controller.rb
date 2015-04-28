class API::V1::WebhooksController < API::BaseController
  before_action :set_agent, only: [:create, :unlink]
  before_action :set_webhook, only: [:show, :agents, :events, :destroy]

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

  # POST /agents/:id/webhooks
  def create
    @webhook = Webhook.find_or_initialize_by(webhook_params.except(:id))
    @webhook.agents << @agent unless @webhook.agents.include?(@webhook)

    if @webhook.save
      render json: @webhook, status: 200,
             notice: 'Webhook was successfully added.'
    else
      fail UnprocessableEntityError, @webhook.errors.full_messages.to_sentence
    end
  end

  # DELETE /agents/:id/webhooks/:id
  def unlink
    @webhook = Webhook.find_by(id: webhook_params[:webhook_id])
    return unless @webhook

    if @webhook.agents.delete(@agent)
      render json: @webhook, status: 200,
             notice: 'Webhook was successfully unlinked.'
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

  def set_webhook
    @webhook = Webhook.find(params[:id])
  end

  def set_agent
    @agent = Agent.find_by(slug: params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def webhook_params
    params.permit(:id, :webhook_id, :url)
  end
end
