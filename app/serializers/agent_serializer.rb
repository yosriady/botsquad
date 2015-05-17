class AgentSerializer < BaseSerializer
  attributes :id, :name, :description, :payload, :interval, :created_at,
             :updated_at, :agent_type, :links

  def id
    object.slug
  end

  def agent_type
    {
      id: object.agent_type.slug,
      href: api_v1_agent_type_url(object.agent_type)
    }
  end

  def links
    l = []
    l << { href: api_v1_agent_url(object),          rel: :self,       method: :GET }
    l << { href: webhooks_api_v1_agent_url(object), rel: :webhooks,   method: :GET }
    l << { href: runs_api_v1_agent_url(object),     rel: :runs,       method: :GET }
  end
end
