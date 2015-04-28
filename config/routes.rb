Rails.application.routes.draw do
  devise_for :users
  namespace :api, defaults: { format: 'json' }, path: '',
                  constraints: { subdomain: 'api' } do
    get '' => 'base#index'

    namespace :v1 do
      get '' => 'base#index'

      resources :agents, only: [:index, :show, :create, :update, :destroy] do
        member do
          get :webhooks
          resources :webhooks, only: [:create]
          delete 'webhooks/:webhook_id' => 'webhooks#unlink'
          get :runs
        end
      end

      resources :webhooks, only: [:show, :destroy] do
        member do
          get :agents
          get :events
        end
      end
      resources :runs, only: [:show] do
        member do
          resources :events, only: [:index], as: :run_events
        end
      end
      resources :agent_types, only: [:index, :show]
      resources :events, only: [:show]
    end
  end

  root 'page#index'

  post 'signup' => 'page#signup'
end
