class CommitRepository < Hanami::Repository
  def all_for_contributor(contributor_id)
    commits.where(contributor_id: contributor_id).to_a
  end
end
