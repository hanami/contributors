module Graphql
  module Types
    Commit = GraphQL::ObjectType.define do
      name "Commit"
      field :id, types.ID
      field :contributor_id, !types.ID
      field :sha, types.String
      field :url, types.String
    end
  end
end
