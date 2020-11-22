Rails.application.routes.draw do

  resources :cupons
  resources :products
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

resources :admins do
  member do
    get 'admin_account'#アカウントページ
  end
end
resources :blogs
  resources :suports
  resources :contacts
  get 'interviews/index'
  get 'subscriptions/index'
  get 'blogs/index'

  resources :interviews
  resources :owners do
      member do
        get 'interviews_index'
        get 'owner_account'#アカウントページ
      end
      resources :shops do
        resources :subscriptions do
          resources :images
        end
      end
  end
  resources :categories

  resources :users do
    member do
      get 'user_account'#アカウントページ
    end
  end
  resources :reviews



  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
