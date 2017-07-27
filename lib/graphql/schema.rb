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
#   contributor(id: "301") {
#     id
#     github
#     full_name
#     avatar_url
#
#     commits {
#       url
#
#       project {
#         name
#       }
#     }
#   }
# }
# QUERY
#
# Graphql::Schema.execute(query_first)
# => {"data"=>{"contributor"=>{"id"=>"301", "github"=>"janx", "full_name"=>nil, "avatar_url"=>"https://avatars3.githubusercontent.com/u/5958?v=3", "commits"=>[{"url"=>"https://github.com/hanami/view/commit/3e94750830a9905390dc823ff91f5ccd485d99ea"}]}}}
