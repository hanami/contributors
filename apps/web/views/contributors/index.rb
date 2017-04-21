module Web::Views::Contributors
  class Index
    include Web::View

    def raw_content
      raw '<h1>Hello World!</h1>'
    end

    def h_content
      h "<script>alert('xss')</script>"
    end

    def link_to_github(contributor)
      link_to contributor.github, "/contributors/#{contributor.github}"
    end

    def all_time_page_class
      'active' if params[:range].nil?
    end

    def today_page_class
      'active' if params[:range] == 'day'
    end

    def this_week_page_class
      'active' if params[:range] == 'week'
    end

    def this_month_page_class
      'active' if params[:range] == 'month'
    end

    def this_year_page_class
      'active' if params[:range] == 'year'
    end
  end
end
