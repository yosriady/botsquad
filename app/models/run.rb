class Run < ActiveRecord::Base
  belongs_to :agent
  has_many :events

  enum status: %w( queued successful failed )

  after_save :enqueue_events_on_success

  def enqueue_events_on_success
    return unless status_changed? && successful?
    enqueue_events
  end

  def enqueue_events
    agent.webhooks.each do |webhook|
      job_params = {
        webhook_id: webhook.id,
        run_id: id
      }
      SendEventJob.perform_later(job_params)
    end
  end
end
