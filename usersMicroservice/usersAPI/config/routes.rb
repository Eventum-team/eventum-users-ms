Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :users, param: :_id
  resources :user_groups, only: [:index, :create]
  get 'user_groups/:user_id/:group_id', to: 'user_groups#show'
  put 'user_groups/:user_id/:group_id', to: 'user_groups#update'
  delete 'user_groups/:user_id/:group_id', to: 'user_groups#destroy'
  resources :user_events, only: [:index, :create]
  get 'user_events/:user_id/:event_id', to: 'user_events#show'
  put 'user_events/:user_id/:event_id', to: 'user_events#update'
  delete 'user_events/:user_id/:event_id', to: 'user_events#destroy'
  root 'users#index'
end
