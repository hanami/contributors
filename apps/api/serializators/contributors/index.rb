module Api::Serializators
  module Contributors
    class Index < Hanami::Serializer::Base
      attribute :github,        ::Types::Github
      attribute :avatar_url,    ::Types::AvatarUrl
      attribute :commits_count, ::Types::CommitsCount
    end
  end
end
