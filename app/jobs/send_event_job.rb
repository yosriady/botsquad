# SendEvent job class
class SendEventJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    p "#{self.class.name}: Performing with arguments: #{args.inspect}"
    webhook = Webhook.find(params[:webhook_id])
    run = Run.find(params[:run_id])
    fail ExecutionError unless webhook.present? && run.present?
    p "#{self.class.name}: Creating event"
    event = Event.create(run_id: run.id, webhook_id: webhook.id)
    p "#{self.class.name}: Created event #{event.id}"
    response = RestClient.post webhook.url,
                               JSON(run.response),
                               content_type: :json,
                               accept: :json
    if response.code == 200
      p "#{self.class.name}: Event #{event.id} sent"
      event.status = Event.statuses[:sent]
    else
      p "#{self.class.name}: Event #{event.id} failed"
      event.status = Event.statuses[:failed] # Automatic Event.rb Retries
    end
    event.save
  end
end
