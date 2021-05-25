Rails.application.routes.draw do
  defaults format: :json do
    namespace :api do
      get '/ping', to: 'ping#index'
    end
  end

  root "web_addresses#index"

  resources :web_addresses, only: [:index, :create, :show]
  get '/:short_url', to: 'web_addresses#show'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
