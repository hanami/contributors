class ContributorSerialization < Dry::Struct
  CommitsCount = Contributor::Types::Strict::Decimal.default { 0 }

  constructor_type :weak

  attribute :github,        Contributor::Types::Strict::String
  attribute :avatar_url,    Contributor::Types::Strict::String
  attribute :commits_count, CommitsCount

  def initialize(attributes)
    attributes = Hash(attributes)
    super
  end

  def to_json(_ = nil)
    JSON.generate(to_h)
  end
  alias_method :call, :to_json
end
