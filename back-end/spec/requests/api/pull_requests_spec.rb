require 'rails_helper'

describe Api::PullRequestsController do
  describe 'GET /api/1.0.0/pull_requests' do
    subject(:make_request) { get '/api/1.0.0/pull_requests' }
    # subject(:make_request) { get :index }

    let!(:pr1) do
      PullRequest.create(id: 1, state: 'closed', user: user, created_at: Time.new(2014, 1, 1, 0, 0, 0))
    end
    let!(:pr2) do
      PullRequest.create(id: 2, state: 'open', user: user, created_at: Time.new(2015, 1, 1, 0, 0, 0))
    end
    let!(:user) { User.create(id: 1, login: 'goodgravy') }

    it 'is successful' do
      make_request
      expect(response).to be_successful
    end

    it 'contains links to the user' do
      make_request
      expect(json_data.map { |pr| pr['links']}).to match_array(['user' => '/api/1.0.0/users/1'] * 2)
    end

    it 'returns all the pull requests' do
      make_request
      expect(json_data.size).to eq(2)
      expect(json_data).to match_array([
        a_hash_including('id' => 1, 'attributes' => a_hash_including('state' => 'closed')),
        a_hash_including('id' => 2, 'attributes' => a_hash_including('state' => 'open')),
      ])
    end
  end
end
