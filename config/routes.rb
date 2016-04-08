require 'api_constraints'

MarketPlaceApi::Application.routes.draw do
  root "main#index"
  get "main/index"
  devise_for :users
  namespace :api, defaults: {format: :json}, constraints: {subdomain: 'api'}, path: '/' do
    scope module: :v1, constraints: ApiConstraints.new(version: 1, default:true) do
      resources :users, :only => [:show, :create, :update, :destroy] do
        resources :type_of_services, :only => [:create, :update, :destroy]
      end
      resources :sessions, :only => [:create, :destroy]
      resources :type_of_services, :only => [:index, :show]
    end
  end
end
