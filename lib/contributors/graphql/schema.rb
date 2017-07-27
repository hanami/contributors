require_relative 'types/commit'
require_relative 'types/contributor'
require_relative 'types/project'
require_relative 'types/query'

module Graphql
  Schema = GraphQL::Schema.define do
    query Types::Query
  end
end
