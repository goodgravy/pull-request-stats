Rails.application.routes.draw do
  namespace :api do
    scope '1.0.0' do
      get 'sync', to: 'github#sync'

      resources :users, only: [:index, :show]
      resources :pull_requests, only: [:index]
    end
  end
end
