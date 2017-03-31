module Web
  module Views
    class ApplicationLayout
      include Web::Layout

      def title
        'Hanami contributors'
      end

      def all_time_page_class
        nil
      end

      def today_page_class
        nil
      end

      def this_week_page_class
        nil
      end

      def this_month_page_class
        nil
      end

      def this_year_page_class
        nil
      end

      def faq_page_class
        nil
      end
    end
  end
end
