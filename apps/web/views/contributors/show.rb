module Web::Views::Contributors
  class Show
    include Web::View
    include Hanami::Pagination::View

    def active_class(page)
      'active' if pager.current_page?(page)
    end

    def project_name(commit)
      matcher = commit.url.match(%r{github.com/hanami/([\w.]+)/})
      matcher && matcher[1]
    end

    def title
      "Commits for #{contributor.github}"
    end

    def show_pagination?
      pager.pager.total_pages > 1
    end
  end
end
