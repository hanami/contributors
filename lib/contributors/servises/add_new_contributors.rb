class AddNewContributors
  def call
    contributors = repo.all
    new_contributors = AllContributors.new.call

    new_contributors.each do |contributor|
      unless contributors.any? { |c| c.github == contributor[:github] }
        repo.create(contributor)
      end
    end
  end

  private

  def repo
    @repo ||= ContributorRepository.new
  end
end
