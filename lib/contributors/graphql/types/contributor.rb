module Graphql
  module Types
    Contributor = GraphQL::ObjectType.define do
      name "Contributor"
      field :id, types.ID
      field :github, types.String
      field :full_name, types.String
      field :avatar_url, types.String
      field :commits_count, types.Int

      field :commits, types[Commit] do
        description "Get all commits for contributor"
        resolve ->(contributor, args, ctx) do
          CommitRepository.new.all_for_contributor(contributor.id)
        end
      end
    end
  end
end
