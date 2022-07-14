Rails.application.routes.draw do

  scope "(:locale)", locale: /en|fr|pt/ do
    devise_for :users, controllers: { registrations: 'registrations' }
    resources :users
    # resources :users, only: [:index, :show, :edit, :update] do
    # end

    concern :radiusable do
      resources :radius_servers
    end
  
    resources :radius_servers do
      member do
        get 'clients', 'proxy', 'users'
      end
    end

    resources :confederations, concerns: :radiusable

    resources :federations, concerns: :radiusable do
      resources :organisations, only: :index
    end

    resources :organisations, concerns: :radiusable do
      resources :realms, :locations, :memberships, :equipment
    end

    resources :locations do
      resources :addresses, only: [:new, :create]
    end

    # resources :radius_servers do
    #   member do
    #     get 'clients', 'proxy'
    #   end
    # end

    get "/pages/:page" => "pages#show"    
    root "pages#show", page: "home"

  end

  # Making sure that the eduroam db validator gets the required URL format
  get 'federations/:id/ro.json', to: 'federations#show', defaults: { format: 'json' }, as: :ro_json
  get 'federations/:federation_id/institution.json', to: 'organisations#index', defaults: { format: 'json' }, as: :institution_json

end