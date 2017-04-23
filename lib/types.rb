module Types
  include Dry::Types.module

  Github = Strict::String
  AvatarUrl = Strict::String
  CommitsCount = Strict::Decimal.default { 0 }

  Commit = Types::Hash.schema(
    sha:        Strict::String,
    url:        Strict::String,
    title:      Strict::String,
    created_at: Strict::Time
  )

  Commits = Types::Strict::Array.member(Commit)
end
