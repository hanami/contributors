class AddNewContributors
  def call
    contributors = repo.all
    new_contributors = AllContributors.new.call

    new_contributors = new_contributors.select do |contributor|
      !contributors.any? { |c| c.github == contributor[:github] }
    end

    repo.create(new_contributors)
  end

  private

  def repo
    @repo ||= ContributorRepository.new
  end
end
