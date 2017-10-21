class Contributor < Hanami::Entity
  attributes do
    attribute :id, Types::Int

    attribute :github,         Types::String
    attribute :full_name,      Types::String
    attribute :avatar_url,     Types::String
    attribute :commits_count,  Types::Int
    attribute :since,          Types::Time

    attribute :created_at, Types::Time
    attribute :updated_at, Types::Time
  end
end
