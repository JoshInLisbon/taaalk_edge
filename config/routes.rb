Rails.application.routes.draw do
  # devise_for :users
  devise_for :users, controllers: { registrations: 'users/registrations', sessions: 'users/sessions' }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: 'tlks#index'
  get 'new', to: 'tlks#newly_created', as: 'newly_created'

  get '/t/:id', to: 'tlks#show', as: 'show_tlk'
  get 't/invite/:id', to: 'invite/tlks#show', as: 'tlk_invite'
  patch 'tlk/invited', to: 'invite/tlks#invited?', as: 'invited_to_tlk'
  resources :tlks, only: [:new, :create, :update, :edit] do
    post :tlk_follows, to: 'tlk_follows#create', as: 'follow'
    delete :tlk_follows, to: 'tlk_follows#destroy', as: 'destroy_follow'
    # resources :tlk_follows, only: [:create, :destroy]
  end

  get '/u/:id', to: 'users#show', as: 'show_user'
  get '/u/:id/taaalk-request', to: 'users#tlk_with_request', as: 'tlk_with_request'
  patch 'tlk-with-me', to: 'users#tlk_with_me', as: 'tlk_with_me'
  patch ':id/send-tlk-request', to: 'users#send_tlk_request', as: 'send_tlk_request'
  resources :users do
    post :user_follows, to: 'user_follows#create', as: 'follow'
    delete :user_follows, to: 'user_follows#destroy', as: 'destroy_follow'
  end

  resources :msgs, only: [:create, :update]

  resources :spkrs, only: [:create, :update, :destroy]
  get 'spkrs/hide', to: 'spkrs#hide_spkr', as: 'hide_spkr'
  get 'spkr/confirm-edit/:id', to: 'spkrs#edit_confirmed', as: 'edit_confirmed'
end
