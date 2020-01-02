Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'tlks#index'
  get '/tlk/:id', to: 'tlks#show', as: 'show_tlk'
  get 'tlk/invite/:id', to: 'invite/tlks#show', as: 'tlk_invite'
  patch 'tlk/jim', to: 'invite/tlks#invited?', as: 'invited_to_tlk'
  # match 'tlk/invite_code' => 'invite/tlk#invited?', via: :post
  resources :tlks, only: [:new, :create, :update, :edit]
  resources :msgs, only: :create
  resources :spkrs, only: [:update]
end
