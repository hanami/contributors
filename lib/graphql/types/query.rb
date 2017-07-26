module Graphql
  module Types
    Query = GraphQL::ObjectType.define do
      name "Query"
      description "The query root of this schema"

      field :contributor, Contributor do
        argument :id, !types.ID
        description "Find a Contributor by ID"
        resolve ->(obj, args, ctx) do
          ContributorRepository.new.find(args['id'])
        end
      end

      field :contributors, types[Contributor] do
        description "Get all Contributors"
        resolve ->(obj, args, ctx) do
          ContributorRepository.new.all
        end
      end
    end
  end
end
