module Graphql
  module Types
    Project = GraphQL::ObjectType.define do
      name "Project"
      field :id, types.ID
      field :name, types.String
    end
  end
end
