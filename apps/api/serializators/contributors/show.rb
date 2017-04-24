module Api::Serializators
  module Contributors
    class Show < Hanami::Serializer::Base
      attribute :github,     ::Types::Github
      attribute :avatar_url, ::Types::AvatarUrl
      attribute :commits,    ::Types::Commits
    end
  end
end
