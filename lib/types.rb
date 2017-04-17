module Types
  include Dry::Types.module

  Github = Types::Strict::String
  AvatarUrl = Types::Strict::String
  CommitsCount = Contributor::Types::Strict::Decimal.default { 0 }
end
