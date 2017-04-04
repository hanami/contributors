class AddNewCommitsWorker
  include Sidekiq::Worker

  def perform
    AddNewCommits.new.call
  end
end
