class RunSerializer < ActiveModel::Serializer
  attributes :id, :agent_id, :status, :result
end
