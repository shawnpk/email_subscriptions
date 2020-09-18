require 'sidekiq/web'

Rails.application.routes.draw do
  resources :projects do
    resources :tasks
  end

  authenticate :user, lambda { |u| u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  devise_for :users
  root to: 'home#index'
end
