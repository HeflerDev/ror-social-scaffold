Rails.application.routes.draw do

  delete 'remove_friend', to: 'friendships#destroy'
  delete 'deny_friend', to: 'friendships#deny'

  root 'posts#index'

  devise_for :users

  resources :friendships
  get '/confirm', to: 'friendships#edit'
  post '/confirm', to: 'friendships#update'

  resources :users, only: [:index, :show]
  resources :posts, only: [:index, :create] do
    resources :comments, only: [:create]
    resources :likes, only: [:create, :destroy]
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
