Rails.application.routes.draw do

  root 'static_pages#top'

  devise_for :admins, controllers: {
    sessions:      'admins/sessions',
    passwords:     'admins/passwords',
    registrations: 'admins/registrations'
  }
  devise_for :owners, controllers: {
    sessions:      'owners/sessions',
    passwords:     'owners/passwords',
    registrations: 'owners/registrations'
  }
  devise_for :users, controllers: {
    omniauth_callbacks:  'users/omniauth_callbacks',
    sessions:      'users/sessions',
    passwords:     'users/passwords',
    registrations: 'users/registrations'
  }

  resources :admins
  resources :blogs
  
  resources :owners
  resources :interviews
  resources :shops
  resources :categories
  resources :subscriptions

  resources :users
  resources :contacts
  resources :reviews



  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
