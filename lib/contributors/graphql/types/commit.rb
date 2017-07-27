module Graphql
  module Types
    Commit = GraphQL::ObjectType.define do
      name "Commit"
      field :id, types.ID
      field :contributor_id, !types.ID
      field :project_id, types.ID
      field :sha, types.String
      field :url, types.String

      field :project, Project do
        description "Get project for commit"
        resolve ->(commit, args, ctx) do
          ProjectRepository.new.find(commit.project_id)
        end
      end
    end
  end
end
