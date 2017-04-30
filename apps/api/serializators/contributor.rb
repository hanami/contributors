module Api::Serializators
  class Contributor < Hanami::Serializer::Base
    attribute :github,        ::Types::Github
    attribute :avatar_url,    ::Types::AvatarUrl
  end
end
