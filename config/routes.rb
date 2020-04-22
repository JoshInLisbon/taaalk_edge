Rails.application.routes.draw do
  # devise_for :users
  devise_for :users, controllers: { registrations: 'users/registrations', sessions: 'users/sessions' }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: 'tlks#index'
  # get 'new', to: 'tlks#newly_created', as: 'newly_created'

  get '/t/:id', to: 'tlks#show', as: 'show_tlk'
  get 't/invite/:id', to: 'invite/tlks#show', as: 'tlk_invite'
  patch 'tlk/invited', to: 'invite/tlks#invited?', as: 'invited_to_tlk'
  get '/start-conversation', to: 'tlks#new', as: 'new_tlk'
  # resources :tlks, only: [:new, :create, :update, :edit] do
  resources :tlks, only: [:create, :update, :edit] do
    post :tlk_follows, to: 'tlk_follows#create', as: 'follow'
    delete :tlk_follows, to: 'tlk_follows#destroy', as: 'destroy_follow'
    # resources :tlk_follows, only: [:create, :destroy]
  end

  get '/u/:id', to: 'users#show', as: 'show_user'
  get '/u/:id/taaalk-request', to: 'users#tlk_with_request', as: 'tlk_with_request'
  patch 'tlk-with-me', to: 'users#tlk_with_me', as: 'tlk_with_me'
  patch 'update-password', to: 'users#update_password', as: 'update_password'
  patch ':id/send-tlk-request', to: 'users#send_tlk_request', as: 'send_tlk_request'
  get ':id/destroy_tlk_with_me', to: 'users#destroy_tlk_with_me', as: 'destroy_tlk_with_me'
  get ':id/destroy_tlk_with_me_user_page', to: 'users#destroy_tlk_with_me_user_page', as: 'destroy_tlk_with_me_user_page'
  resources :users do
    post :user_follows, to: 'user_follows#create', as: 'follow'
    delete :user_follows, to: 'user_follows#destroy', as: 'destroy_follow'
  end

  resources :msgs, only: [:create, :update]

  resources :spkrs, only: [:create, :update, :destroy]
  delete 'spkr/remove', to: 'spkrs#remove', as: 'remove_spkr'
  get 'spkrs/hide', to: 'spkrs#hide_spkr', as: 'hide_spkr'
  get 'spkrs/hide_other', to: 'spkrs#hide_other_spkr', as: 'hide_other_spkr'
  get 'spkr/confirm-edit/:id', to: 'spkrs#edit_confirmed', as: 'edit_confirmed'
  get 'spkr/reject-edit/:id', to: 'spkrs#edit_rejected', as: 'edit_rejected'
  get '/t/:tlk_id/spkr-update/:id', to: 'spkrs#edit_suggested', as: 'edit_suggested'

  get '/t/request/:id', to: 'tlk_requests#show', as: 'tlk_request'
  get '/t/request-accepted/:id', to: 'tlk_requests#accept', as: 'tlk_request_accept'
  get '/t/request-rejected/:id', to: 'tlk_requests#reject', as: 'tlk_request_reject'

  get 'index_got_it', to: 'cookies#index_got_it_cookie', as: 'index_got_it_cookie'

  get 'terms', to: 'pages#terms', as: 'terms'
  get 'privacy', to: 'pages#privacy', as: 'privacy'
end
