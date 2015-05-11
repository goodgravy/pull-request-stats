require 'rails_helper'

describe Api::UsersController do
  let!(:user1) { User.create(id: 1, login: 'goodgravy') }
  let!(:user2) { User.create(id: 2, login: 'badgravy') }

  describe 'GET /api/1.0.0/users' do
    subject(:make_request) { get '/api/1.0.0/users' }

    it 'is successful' do
      make_request
      expect(response).to be_successful
    end

    it 'returns both users' do
      make_request
      expect(json_data).to match_array([
        a_hash_including('id' => 1, 'attributes' => {'login' => 'goodgravy'}),
        a_hash_including('id' => 2, 'attributes' => {'login' => 'badgravy'}),
      ])
    end
  end

  describe 'GET /api/1.0.0/users/:id' do
    subject(:make_request) { get "/api/1.0.0/users/#{id}" }

    context 'id: 1' do
      let(:id) { 1 }

      it 'is successful' do
        make_request
        expect(response).to be_successful
        expect(json_data).to eq(
          'id' => 1,
          'type' => 'user',
          'attributes' => {'login' => 'goodgravy'},
          'links' => {'pull_requests' => []},
        )
      end
    end

    context 'id: 0' do
      let(:id) { 0 }

      it 'is not found' do
        make_request

        expect(response.status).to eq(404)
        expect(json_errors.size).to eq(1)
      end
    end
  end
end
