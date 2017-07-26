module Graphql
  module Types
    Query = GraphQL::ObjectType.define do
      name "Query"
      description "The query root of this schema"

      field :contributor do
        type Contributor
        argument :id, !types.ID
        description "Find a Contributor by ID"
        resolve ->(obj, args, ctx) { ContributorRepository.new.find(args['id']) }
      end
    end
  end
end
