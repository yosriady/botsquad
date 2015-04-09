class WebhookSerializer < ActiveModel::Serializer
  attributes :id, :agent_id, :status, :url, :created_at, :modified_at
end
