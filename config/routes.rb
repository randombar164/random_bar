Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'page#root'

  namespace :api do
    namespace :v1 do
      # define api endpoints
      get 'concrete_drinks' => 'concrete_drinks#index'
      get 'base_ingredients/:id' => 'base_ingredients#show'
      get 'base_ingredients/:id/base_drinks_count' => 'base_ingredients#base_drinks_count'
      get 'base_ingredients' => 'base_ingredients#index'
      post 'events' => 'events#create'
      get 'events/:uuid' => 'events#show'
      patch 'events/:uuid' => 'events#update'
    end
  end
end
