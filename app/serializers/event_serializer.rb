class EventSerializer < ActiveModel::Serializer
  attributes :id, :run_id, :webhook_id, :status
end
