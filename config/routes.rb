Rails.application.routes.draw do

  root 'static_pages#top'
  get 'static_pages/discussion'

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
  resources :suports
  resources :contacts
  get 'interviews/index'
  get 'subscriptions/index'
  get 'blogs/index'

  resources :owners do
    resources :interviews
      collection do
        get 'interviews_index'
      end
      resources :shops do
        resources :subscriptions do
          resources :images
        end
      end
  end
  resources :categories

  resources :users
  resources :reviews



  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
