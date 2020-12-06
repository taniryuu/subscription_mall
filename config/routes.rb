Rails.application.routes.draw do

  root 'static_pages#top'#トップページ
  get 'static_pages/discussion'#相談窓口

  get 'subscriptions/setup', to: 'subscriptions#setup', as: :setup_subscriptions
  get '/cancel', to: 'subscriptions#cancel'
  get '/success', to: 'subscriptions#success'

  get 'categories/shop_list', to: 'categories#shop_list', as: :shop_list_categories
  get 'categories/recommend', to: 'categories#recommend', as: :recommend_categories

  get 'subscriptions/show_sample', to: 'subscriptions#show_sample', as: :show_sample_subscriptions

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
  devise_scope :users do
   get 'users/sign_up', to: 'users#new'
  end

  resources :admins do
    member do
      get 'admin_account'#アカウントページ
    end
  end

  resources :blogs
  get 'interviews/index'#まだ決まってない。使わないかもしれない
  get 'subscriptions/index'#まだ決まってない。使わないかもしれない
  get 'blogs/index'#まだ決まってない。使わないかもしれない

  get 'suports', to: "suports#index"#サポート画面
  post 'suports/confirm' => "suports#confirm"#サポート確認画面
  post 'suports/thanks' => "suports#thanks"#サポート完了通知仮面

  get 'contacts', to: "contacts#index"#お問い合わせ画面
  post 'contacts/confirm' => "contacts#confirm"#お問い合わせ確認画面
  post 'contacts/thanks' => "contacts#thanks"#お問い合わせ完了通知仮面

  resources :interviews
  resources :cupons
  resources :products

  get 'owners/deleted_owners'#論理削除された経営者
  resources :owners do
      member do
        get 'interviews_index'#まだ決まってない。使わないかもしれない
        post "thanks"#会員登録完了通知画面
        get 'owner_account'#アカウントページ
        get 'user_email'#経営者から利用者へメール作成
        post 'to_user_email'
        patch 'update_deleted_owners'#アカウントページ論理削除
      end
      resources :shops do
        resources :subscriptions do
          resources :images
        end
      end
  end
  resources :categories
  get 'users/deleted_users'##論理削除された利用者
  resources :users do
    member do
      get "thanks"#会員完了通知仮面
      get 'user_account'#アカウントページ
      patch 'update_deleted_users'#アカウントページ論理削除
    end
  end
  resources :reviews
  resources :questions

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
