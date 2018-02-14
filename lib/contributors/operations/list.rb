require 'hanami/interactor'

module Operations
  class List
    include Hanami::Interactor
    expose :contributors

    def call
      @contributors = []
    end
  end
end
