class Event < ActiveRecord::Base
  belongs_to :run
  belongs_to :webhook

  enum status: %w( queued sent failed )

  def resend
    # TODO
  end
end
