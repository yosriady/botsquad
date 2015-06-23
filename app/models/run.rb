class Run < ActiveRecord::Base
  belongs_to :agent
  has_many :events

  enum status: %w( queued successful failed )

  after_save :enqueue_events_on_success

  def enqueue_events_on_success
    return unless status_changed? && successful?
    return if agent.webhooks.empty?
    enqueue_events
  end

  # For each Webhook, enqueue a SendEventJob with webhook_id and run_id param
  def enqueue_events
    # TOFIX: agent is null, is run created with the wrong agent_id?
    agent.webhooks.each do |webhook|
      job_params = {
        webhook_id: webhook.id,
        run_id: id
      }
      SendEventJob.perform_later(job_params)
    end
  end
end
