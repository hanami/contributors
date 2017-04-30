require_relative '../contributor'

module Api::Serializators
  module Contributors
    class Show < Contributor
      attribute :commits,    ::Types::Commits
    end
  end
end
