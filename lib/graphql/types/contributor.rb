module Graphql
  module Types
    Contributor = GraphQL::ObjectType.define do
      name "Contributor"
      field :id, types.ID
      field :github, types.String
      field :full_name, types.String
      field :avatar_url, types.String
      field :commits_count, types.Int
    end
  end
end
