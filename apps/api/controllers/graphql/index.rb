module Api::Controllers::Graphql
  class Index
    include Api::Action

    def call(params)
      self.body = Graphql::Schema.execute(params[:query]).to_json
    end
  end
end
