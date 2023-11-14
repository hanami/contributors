require 'hanami/interactor'

module Operations
  class Detail
    include Hanami::Interactor
    expose :contributor

    def call
      @contributor = nil
    end
  end
end
