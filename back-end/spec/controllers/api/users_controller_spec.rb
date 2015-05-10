require 'rails_helper'

describe Api::UsersController do
  let!(:user1) { User.create(id: 1, login: 'goodgravy') }
  let!(:user2) { User.create(id: 2, login: 'badgravy') }

  describe 'GET index' do
    it 'is successful' do
      get :index

      expect(response).to be_successful
      expect(json_data).to match_array([
        {'id' => 1,'login' => 'goodgravy'},
        {'id' => 2,'login' => 'badgravy'}
      ])
    end
  end

  describe 'GET show/1' do
    context 'id: 1' do
      it 'is successful' do
        get :show, id: 1

        expect(response).to be_successful
        expect(json_data).to eq({'id' => 1,'login' => 'goodgravy'})
      end
    end

    context 'id: 0' do
      it 'is not found' do
        get :show, id: 0

        expect(response).to be_not_found
        expect(json_data).to eq({})
      end
    end
  end
end
