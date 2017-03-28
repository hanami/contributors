module Web
  module Views
    class ApplicationLayout
      include Web::Layout

      def title
        'Hanami contributors'
      end
    end
  end
end
