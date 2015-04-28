Rails.application.routes.draw do
  devise_for :users
  namespace :api, defaults: { format: 'json' }, path: '',
                  constraints: { subdomain: 'api' } do
    get '' => 'base#index'

    namespace :v1 do
      get '' => 'base#index'

      resources :agents, only: [:index, :show, :create, :update, :destroy] do
        member do
          resources :webhooks, only: [:index, :create]
          resources :runs, only: [:index]
        end
      end

      resources :webhooks, only: [:show, :destroy] do
        resources :events, only: [:index]
      end
      resources :runs, only: [:show] do
        resources :events, only: [:index]
      end
      resources :agent_types, only: [:index, :show]
      resources :events, only: [:show]
    end
  end

  root 'page#index'

  post 'signup' => 'page#signup'
end
