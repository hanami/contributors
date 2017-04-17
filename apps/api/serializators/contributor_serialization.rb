class ContributorSerialization < Dry::Struct
  constructor_type :weak

  attribute :github,        ::Types::Github
  attribute :avatar_url,    ::Types::AvatarUrl
  attribute :commits_count, ::Types::CommitsCount

  def initialize(attributes)
    attributes = Hash(attributes)
    super
  end

  def to_json(_ = nil)
    JSON.generate(to_h)
  end
  alias_method :call, :to_json
end
