require 'rails_helper'

describe Api::PullRequestsController do
  describe 'GET index' do
    let!(:pr1) { PullRequest.create(id: 1, state: 'closed', created_at: Time.new(2014, 1, 1, 0, 0, 0)) }
    let!(:pr2) { PullRequest.create(id: 2, state: 'open', created_at: Time.new(2015, 1, 1, 0, 0, 0)) }

    it 'is successful' do
      get :index

      expect(response).to be_successful
    end
  end
end
