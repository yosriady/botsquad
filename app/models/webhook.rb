class Webhook < ActiveRecord::Base
  has_and_belongs_to_many :agents
  has_many :events

  enum status: %w( unverified active disabled )

  def verify(challenge_response)
    # TODO: https://developers.braintreepayments.com/ios+ruby/guides/webhooks/create#destination-verification
  end
end
