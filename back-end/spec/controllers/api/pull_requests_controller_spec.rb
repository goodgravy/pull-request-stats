require 'rails_helper'

describe Api::PullRequestsController do
  describe 'GET index' do
    let!(:pr1) { PullRequest.create(id: 1, state: 'closed', created_at: Time.new(2014, 1, 1, 0, 0, 0)) }
    let!(:pr2) { PullRequest.create(id: 2, state: 'open', created_at: Time.new(2015, 1, 1, 0, 0, 0)) }

    it 'is successful' do
      get :index

      expect(response).to be_successful
    end

    context 'with no parameters' do
      it 'returns all the pull requests' do
        get :index

        expect(json_data.size).to eq(2)
        expect(json_data.map { |pr| pr['id'] }).to match_array([1, 2])
      end
    end

    context 'with a from parameter' do
      it 'returns newer pull requests' do
        get :index, from: DateTime.new(2014, 6, 1, 0, 0, 0)

        expect(json_data.map { |pr| pr['id'] }).to match_array([2])
      end
    end

    context 'with an until parameter' do
      it 'returns older pull requests' do
        get :index, until: DateTime.new(2014, 6, 1, 0, 0, 0)

        expect(json_data.map { |pr| pr['id'] }).to match_array([1])
      end
    end
  end
end
