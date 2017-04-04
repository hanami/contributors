class AddNewContributorsWorker
  include Sidekiq::Worker

  def perform
    AddNewContributors.new.call
  end
end
