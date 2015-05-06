require 'rails_helper'

describe Github::PullRequest do
  describe '.since' do
    subject(:since_april_2015) do
      from_time = DateTime.parse('2015-04-28T00:00:00Z')
      described_class.since(from_time)
    end

    it 'returns the right number of pull requests' do
      # 131 PRs match from the fixtures
      expect(since_april_2015.size).to eq(131)
    end

    it 'has the correct content for the first pull request' do
      expected = {
        url: 'https://api.github.com/repos/teespring/rails-teespring/pulls/5754',
        id: 34755421,
        number: 5754,
        state: 'open',
        created_at: '2015-05-05T18:54:47Z',
        updated_at: '2015-05-05T19:02:04Z',
        closed_at: nil,
        merged_at: nil,
      }

      first_pr = since_april_2015.first
      expected.each do |key, value|
        expect(first_pr[key.to_s]).to eq(value)
      end
    end
  end
end

