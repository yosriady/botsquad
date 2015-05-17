class Event < ActiveRecord::Base
  belongs_to :run
  belongs_to :webhook

  enum status: %w( queued sent failed )

  after_save :resend_on_failure

  def resend_on_failure
    return unless status_changed? && failed?
    resend
  end

  def resend
    job_params = {
      webhook_id: event.webhook_id,
      run_id: event.run_id
    }
    SendEventJob.perform_later(job_params)
  end
end
