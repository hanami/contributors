module Graphql
  Schema = GraphQL::Schema.define do
    query Types::Query
  end
end
