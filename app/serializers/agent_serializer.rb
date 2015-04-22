class AgentSerializer < ActiveModel::Serializer
  attributes :slug, :interval, :type, :name, :description, :user_id, :payload
end
