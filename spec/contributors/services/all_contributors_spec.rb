RSpec.describe AllContributors do
  let(:repo) { ProjectRepository.new }

  before do
    repo.create(name: 'contributors')
    repo.create(name: 'utils')
  end

  after do
    repo.clear
  end

  it 'returns array of contributors' do
    VCR.use_cassette("contributors") do
      result = described_class.new.call

      contributors = result.select { |i| %w(davydovanton jodosha).include?(i[:github]) }

      expect(contributors.size).to eq(2)
      contributors.each do |h|
        expect(h[:avatar_url]).to be
      end
    end
  end

  it 'returns array of contributors for given project' do
    VCR.use_cassette("contributors") do
      result = described_class.new.for_project(repo.first)

      contributors = result.select { |i| %w(davydovanton jodosha).include?(i[:github]) }

      expect(contributors.size).to eq(2)
      contributors.each do |h|
        expect(h[:avatar_url]).to be
      end
    end
  end
end
