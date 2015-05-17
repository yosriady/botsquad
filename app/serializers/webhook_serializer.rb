class WebhookSerializer < BaseSerializer
  attributes :id, :status, :url, :created_at, :updated_at, :links

  def links
    l = []
    l << { href: api_v1_webhook_url(object),        rel: :self,    method: :GET }
    l << { href: agents_api_v1_webhook_url(object), rel: :agents,  method: :GET }
    l << { href: events_api_v1_webhook_url(object), rel: :events,  method: :GET }
  end
end
