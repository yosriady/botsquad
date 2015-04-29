class AgentTypeSerializer < BaseSerializer
  attributes :id, :name, :description, :sample_payload, :sample_response,
             :created_at, :updated_at, :links

  def id
    object.slug
  end

  def links
    l = []
    l << { href: api_v1_agent_type_url(object),    rel: :self,  method: :GET }
    l
  end
end
