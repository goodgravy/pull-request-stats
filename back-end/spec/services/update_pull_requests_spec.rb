require 'rails_helper'

describe UpdatePullRequests do
  subject(:update_prs) { described_class[] }

  let!(:gh_adapter) { class_double(Github::PullRequest).as_stubbed_const }

  before do
    allow(gh_adapter).to receive(:since).and_return([])
  end

  context 'with no pull requests in DB' do

    it 'fetches pull requests from the beginning of time' do
      expect(gh_adapter).to receive(:since).with(DateTime.new(1970, 1, 1, 0, 0, 0))
      update_prs
    end
  end

  context 'with one closed pull request' do
    let!(:pr) { PullRequest.create(id: 1, state: 'closed', closed_at: Time.new(2014, 1, 1, 0, 0, 0)) }

    it 'fetches pull requests since that pull request' do
      expect(gh_adapter).to receive(:since).with(pr.closed_at)
      update_prs
    end

    context 'and a pull request returned from GH' do
      before { expect(gh_adapter).to receive(:since).and_return([pr_from_gh]) }

      let(:pr_id) { 1 }
      let(:pr_from_gh) do {
          'id' => pr_id,
          'url' => 'http://thing.com',
          'number' => 42,
          'state' => 'open',
          'created_at' => '2015-05-06T00:00:00Z',
          'updated_at' => '2015-05-06T02:00:00Z',
          'closed_at' => nil,
          'merged_at' => nil,
          'user' => {
            'login' => 'goodgravy',
            'id' => 3,
          }
        }
      end

      context 'which is already in the database' do
        let(:pr_id) { 1 }

        it 'updates the existing pull request' do
          update_prs

          pr.reload
          pr_from_gh.except('user').each do |key, value|
            expect(pr.send(key)).to eq(value)
          end
        end
      end

      context 'which is new' do
        let(:pr_id) { 2 }

        it 'adds the new pull request to the database' do
          update_prs

          pr_from_gh.except('user').each do |key, value|
            expect(PullRequest.last.send(key)).to eq(value)
          end
        end
      end

      context 'with a new user' do
        it 'creates a user in the database' do
          expect { update_prs }.to change { User.count }.by(1)

          pr_from_gh['user'].each do |key, value|
            expect(User.last.send(key)).to eq(value)
          end
        end
      end
    end
  end
end
