module Graphql
  Schema = GraphQL::Schema.define do
    query Types::Query
  end
end

# query_all = <<-QUERY
# {
#   contributors {
#     id
#     github
#     full_name
#     avatar_url
#   }
# }
# QUERY
#
# Graphql::Schema.execute(query_all)
# # => [{"data"=>{"contributor"=>{"id"=>"101", "github"=>"jodosha", "full_name"=>nil, "avatar_url"=>"https://avatars2.githubusercontent.com/u/5089?v=3"}}}, ...]

# query_first = <<-QUERY
# {
#   contributor(id: "101") {
#     id
#     github
#     full_name
#     avatar_url
#   }
# }
# QUERY
#
# Graphql::Schema.execute(query)
# # => {"data"=>{"contributor"=>{"id"=>"101", "github"=>"jodosha", "full_name"=>nil, "avatar_url"=>"https://avatars2.githubusercontent.com/u/5089?v=3"}}}
