class BaseSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  # TODO: Define helpers mehods:
  # - Introspected 'self' urls
  # - HATEOAS links


end