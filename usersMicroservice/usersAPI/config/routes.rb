Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :users, param: :_id
  get 'groups_by_user/:_id', to: 'users#showGroups'
  get 'events_by_user/:_id', to: 'users#showEvents'

  resources :user_groups, only: [:index, :create]
  get 'user_groups/:user_id/:group_id', to: 'user_groups#show'
  get 'user_groups/:group_id', to: 'user_groups#showUsers'
  get 'admin_groups/:group_id', to: 'user_groups#showAdmins'
  put 'user_groups/:user_id/:group_id', to: 'user_groups#update'
  delete 'user_groups/:user_id/:group_id', to: 'user_groups#destroy'

  resources :user_events, only: [:index, :create]
  get 'user_events/:user_id/:event_id', to: 'user_events#show'
  get 'assistant_events/:event_id', to: 'user_events#showAssistants'
  get 'interested_events/:event_id', to: 'user_events#showInterested'
  put 'user_events/:user_id/:event_id', to: 'user_events#update'
  delete 'user_events/:user_id/:event_id', to: 'user_events#destroy'

  root 'users#index'
end
