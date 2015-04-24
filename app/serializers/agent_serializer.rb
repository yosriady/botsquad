class AgentSerializer < ActiveModel::Serializer
  attributes :id, :slug, :name, :agent_type, :description, :payload, :interval, :links

  def agent_type
    {
      slug: object.agent_type.slug,
      url: api_v1_agent_type_url(object.agent_type)
    }
  end

  def links
    {
      self: api_v1_agent_url(object),
      webhooks: "test",
      runs: "test"
    }
  end
end
