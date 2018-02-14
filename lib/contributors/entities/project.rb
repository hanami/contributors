class Project < Hanami::Entity
  attributes do
    attribute :id,    Types::Int

    attribute :name,  Types::String
    attribute :owner, Types::String
  end
end
