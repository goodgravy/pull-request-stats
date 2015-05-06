require 'rails_helper'

describe UpdatePullRequests do
  subject(:upr) { described_class[] }

  let!(:gh_adapter) { class_double(Github::PullRequest).as_stubbed_const }

  before do
    allow(gh_adapter).to receive(:since).and_return([])
  end

  context 'with no pull requests in DB' do

    it 'fetches pull requests from the beginning of time' do
      expect(gh_adapter).to receive(:since).with(DateTime.new(1970, 1, 1, 0, 0, 0))
      upr
    end
  end

  context 'with one closed pull request' do
    let!(:pr) { PullRequest.create(id: 1, state: 'closed', closed_at: Time.new(2014, 1, 1, 0, 0, 0)) }

    it 'fetches pull requests since that pull request' do
      expect(gh_adapter).to receive(:since).with(pr.closed_at)
      upr
    end

    context 'and a new pull request returned from GH' do
      it 'adds the new pull request to the database' do
        new_pr_params = {
          id: 2,
          url: 'http://thing.com',
          number: 42,
          state: 'open',
          created_at: '2015-05-06T00:00:00Z',
          updated_at: '2015-05-06T02:00:00Z',
          closed_at: nil,
          merged_at: nil,
        }.stringify_keys
        expect(gh_adapter).to receive(:since).and_return([new_pr_params])

        upr

        new_pr_params.each do |key, expected_value|
          expect(PullRequest.last.send(key)).to eq(expected_value)
        end
      end
    end

    context 'and an updated pull request returned from GH' do
      it 'updates the existing pull request' do
        updated_pr_params = {
          id: 1,
          url: 'http://thing.com',
          number: 42,
          state: 'open',
          created_at: '2015-05-06T00:00:00Z',
          updated_at: '2015-05-06T02:00:00Z',
          closed_at: nil,
          merged_at: nil,
        }.stringify_keys

        expect(gh_adapter).to receive(:since).and_return([updated_pr_params])

        upr

        pr.reload
        updated_pr_params.each do |key, expected_value|
          expect(pr.send(key)).to eq(expected_value)
        end
      end
    end
  end
end
