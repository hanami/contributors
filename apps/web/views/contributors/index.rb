module Web::Views::Contributors
  class Index
    include Web::View

    def link_to_github(contributor)
      link_to contributor.github, "https://github.com/#{contributor.github}"
    end
  end
end
