module Web::Controllers::Contributors
  class Index
    include Web::Action
    expose :contributors

    def call(params)
      @contributors = contributor_list || []
    end

    private

    ONE_DAY = 60 * 60 * 24

    def contributor_list
      range = date_range(params[:range])
      range ? repo.with_commit_range(range) : repo.all_with_commits_count
    end

    def date_range(key)
      case key
      when 'day'   then (Time.now - ONE_DAY)..Time.now
      when 'week'  then (Time.now - ONE_DAY * 7)..Time.now
      when 'month' then (Time.now - ONE_DAY * 31)..Time.now
      when 'year'  then (Time.now - ONE_DAY * 365)..Time.now
      else
        nil
      end
    end

    def repo
      @repo ||= ContributorRepository.new
    end
  end
end
