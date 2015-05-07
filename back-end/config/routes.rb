Rails.application.routes.draw do
  namespace :api, constraints: { format: 'json' } do
    scope '1.0.0' do
      resources :users, only: %i(index show)
      resources :pull_requests, only: %i(index)
    end
  end
end
