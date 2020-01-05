Rails.application.routes.draw do
  # devise_for :users
  devise_for :users, controllers: { registrations: 'users/registrations', sessions: 'users/sessions' }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'tlks#index'
  get '/tlk/:id', to: 'tlks#show', as: 'show_tlk'
  get 'tlk/invite/:id', to: 'invite/tlks#show', as: 'tlk_invite'
  patch 'tlk/invited', to: 'invite/tlks#invited?', as: 'invited_to_tlk'
  resources :tlks, only: [:new, :create, :update, :edit]
  resources :msgs, only: :create
  resources :spkrs, only: [:create, :update, :destroy]
  get 'spkrs/hide', to: 'spkrs#hide_spkr', as: 'hide_spkr'
end
