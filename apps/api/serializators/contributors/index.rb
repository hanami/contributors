require_relative '../contributor'

module Api::Serializators
  module Contributors
    class Index < Contributor
      attribute :commits_count, ::Types::CommitsCount
    end
  end
end
