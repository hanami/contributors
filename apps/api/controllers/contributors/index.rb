module Api::Controllers::Contributors
  class Index
    include Api::Action

    def call(params)
      self.body = JSON.generate({})
    end
  end
end
