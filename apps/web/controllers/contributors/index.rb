module Web::Controllers::Contributors
  class Index
    include Web::Action
    expose :contributors

    def call(params)
      range = date_range(params[:range])
      @contributors = ContributorRepository.new.all_with_commits(range)
    end

    private

      ONE_DAY = 60 * 60 * 24

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
  end
end
