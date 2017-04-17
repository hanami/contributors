module Api::Serializators
  module Contributors
    class Index < Base
      attribute :github,        ::Types::Github
      attribute :avatar_url,    ::Types::AvatarUrl
      attribute :commits_count, ::Types::CommitsCount
    end
  end
end
