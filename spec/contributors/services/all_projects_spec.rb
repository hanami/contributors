RSpec.describe AllProjects do
  it 'returns array of projects' do
    VCR.use_cassette("repositories") do
      projects = described_class.new("hanami").call

      expect(projects.size).to eq(21)
      projects.each do |project_data|
        expect(project_data[:name]).to be
        expect(project_data[:owner]).to eq "hanami"
      end
    end
  end
end
