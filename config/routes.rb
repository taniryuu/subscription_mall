Rails.application.routes.draw do

  root 'static_pages#top'#トップページ
  get 'static_pages/top_owner' => "static_pages#top_owner"#経営者様トップページ
  get 'static_pages/top_user' => "static_pages#top_user"#利用者様トップページ
  get 'static_pages/discussion'#相談窓口

  get 'subscriptions/setup', to: 'subscriptions#setup', as: :setup_subscriptions
  get 'subscriptions/user_plans/user/:id', to: 'subscriptions#user_plans', as: :user_plans
  get '/cancel', to: 'subscriptions#cancel'
  get '/success', to: 'subscriptions#success'

  get 'categories/shop_list', to: 'categories#shop_list', as: :shop_list_categories
  get 'categories/recommend', to: 'categories#recommend', as: :recommend_categories

  get 'subscriptions/show_sample', to: 'subscriptions#show_sample', as: :show_sample_subscriptions

  get 'user/:id/ticket', to: 'users#ticket', as: :ticket

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
      get 'admin_account', on: :member#アカウントページ
  end
  resources :blogs#管理者が書くサブスクnews
  get 'reviews/list' => "reviews#list"#利用者ではない人用の表示ページ
  get 'subscriptions/index'#まだ決まってない。使わないかもしれない
  get 'blogs/index'#まだ決まってない。使わないかもしれない

  get 'suports', to: "suports#index"#サポート画面
  post 'suports/confirm' => "suports#confirm"#サポート確認画面
  post 'suports/thanks' => "suports#thanks"#サポート完了通知仮面

  get 'contacts', to: "contacts#index"#お問い合わせ画面
  post 'contacts/confirm' => "contacts#confirm"#お問い合わせ確認画面
  post 'contacts/thanks' => "contacts#thanks"#お問い合わせ完了通知仮面

  resources :interviews#経営者様インタビュー
  resources :cupons#クーポン
  resources :products#QRコード

  get 'owners/deleted_owners'#論理削除された経営者
  resources :owners do
        post "thanks", on: :member#会員登録完了通知画面
        get 'owner_account', on: :member#アカウントページ
        get 'user_email', on: :member#経営者から利用者へメール作成
        post 'to_user_email', on: :member
        patch 'update_deleted_owners', on: :member#アカウントページ論理削除
      resources :shops do
        resources :subscriptions do
          resources :images
        end
      end
  end
  resources :categories, only: :index do
      get 'like_lunch', on: :member
      get 'washoku', on: :collection
      get 'teishoku', on: :collection
      get 'ramen', on: :collection
      get 'cafe', on: :collection
      get 'pan', on: :collection
      get 'izakaya', on: :collection
      get 'itarian', on: :collection
      get 'chuuka', on: :collection
      get 'french', on: :collection
      get 'hawaian', on: :collection
      get 'tonanajia', on: :collection
      get 'bar', on: :collection
      get 'cake', on: :collection
      get 'yakiniku', on: :collection
      get 'yoshoku', on: :collection
      get 'curry', on: :collection
      get 'humburger', on: :collection
      get 'kankokuryori', on: :collection
      get 'restaurant', on: :collection
      get 'other', on: :collection
  end
  get 'users/deleted_users'##論理削除された利用者
  resources :users do
    resources :reviews#利用者レビュー
      get "thanks", on: :member#会員完了通知仮面
      get 'user_account', on: :member#アカウントページ
      patch 'update_deleted_users', on: :member#アカウントページ論理削除
  end
  resources :questions#よくある質問

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
