module Graphql
  module Types
    Project = GraphQL::ObjectType.define do
      name "Project"
      field :id, types.ID
      field :name, types.String
      field :owner, types.String
    end
  end
end
