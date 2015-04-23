class AgentTypeSerializer < ActiveModel::Serializer
  attributes :slug, :name, :description, :sample_payload, :sample_response,
             :job_type, :script_path, :created_at, :updated_at
end
