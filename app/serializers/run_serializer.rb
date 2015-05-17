class RunSerializer < BaseSerializer
  attributes :id, :agent_id, :status, :response, :links

  def links
    l = []
    l << { href: api_v1_run_url(object),          rel: :self,       method: :GET }
    l << { href: events_api_v1_run_url(object),   rel: :events,   method: :GET }
  end

end
