Rails.application.routes.draw do

  get 'users/new'

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
    sessions:      'users/sessions',
    passwords:     'users/passwords',
    registrations: 'users/registrations'
  }

  resources :admins
  resources :owners
  resources :users


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
