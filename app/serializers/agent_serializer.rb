class AgentSerializer < ActiveModel::Serializer
  attributes :interval, :type, :name, :description, :user_id, :payload
end
