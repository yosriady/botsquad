class API::V1::WebhooksController < API::BaseController
  before_action :set_agent, only: [:index, :create]
  before_action :set_webhook, only: [:show, :destroy]

  # GET /webhooks
  def index
    render json: @agent.webhooks, root: :webhooks
  end

  # GET /webhooks/1
  def show
    render json: @webhook
  end

  # POST /webhooks
  def create
    @webhook = Webhook.new(webhook_params)

    if @webhook.save
      render json: @webhook, status: 200, notice: 'Webhook was successfully updated.'
    else
      render status: 422
    end
  end

  # DELETE /webhooks/1
  def destroy
    if @webhook.destroy
      render json: @webhook, status: 200, notice: 'Webhook was successfully destroyed.'
    else
      render status: 422
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
      params.require(:webhook).permit(:status, :agent_id, :url)
    end
end
