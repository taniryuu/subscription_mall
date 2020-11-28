Rails.application.routes.draw do

  root 'static_pages#top'
  get 'static_pages/discussion'

  get 'subscriptions/setup', to: 'subscriptions#setup', as: :setup_subscriptions
  get '/cancel', to: 'subscriptions#cancel'
  get '/success', to: 'subscriptions#success'

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
  get 'interviews/index'
  get 'subscriptions/index'
  get 'blogs/index'

  get 'suports', to: "suports#index"#サポート画面
  post 'suports/confirm' => "suports#confirm"#サポート確認画面
  post 'suports/thanks' => "suports#thanks"#サポート完了通知仮面

  get 'contacts', to: "contacts#index"#お問い合わせ画面
  post 'contacts/confirm' => "contacts#confirm"#お問い合わせ確認画面
  post 'contacts/thanks' => "contacts#thanks"#お問い合わせ完了通知仮面

  resources :interviews
  resources :cupons
  resources :products

  get 'owners/deleted_owners'
  resources :owners do
      member do
        get 'interviews_index'
        post "thanks"#会員登録完了通知仮面
        get 'owner_account'#アカウントページ
        patch 'update_deleted_owners'
      end
      resources :shops do
        resources :subscriptions do
          resources :images
        end
      end
  end
  resources :categories
  get 'users/deleted_users'
  resources :users do
    member do
      post "thanks"#会員完了通知仮面
      get 'user_account'#アカウントページ
      patch 'update_deleted_users'
    end
  end
  resources :reviews



  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
