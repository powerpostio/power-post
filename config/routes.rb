Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  get "planos" => "premium#index"

  root to: 'home#index'
end
