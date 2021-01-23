Rails.application.routes.draw do

  root 'static_pages#top'#トップページ
  get 'top_owner' => "static_pages#top_owner"#経営者様トップページ
  get 'top_user' => "static_pages#top_user"#利用者様トップページ
  get 'discussion' => "static_pages#discussion"#相談窓口
  get 'how_to_use' => "subscriptions#how_to_use", as: :how_to_use#ご利用方法について
  get 'plan_description' => "subscriptions#plan_description", as: :plan_description#プラン説明
  get 'kiyaku' => "subscriptions#kiyaku", as: :kiyaku#利用規約
  get 'privacy_policy' => "subscriptions#privacy_policy", as: :privacy_policy#プライバシーポリシー
  get 'site' => "subscriptions#site", as: :site#サイトについて

  get 'subscriptions/setup', to: 'subscriptions#setup', as: :setup_subscriptions
  get 'subscriptions/user_plans/user/:id', to: 'subscriptions#user_plans', as: :user_plans#利用者のプラン内容
  get '/cancel', to: 'subscriptions#cancel'
  get '/success', to: 'subscriptions#success'

  get 'categories/shop_list', to: 'categories#shop_list', as: :shop_list_categories
  get 'categories/recommend', to: 'categories#recommend', as: :recommend_categories#おすすめショップ

  get 'subscriptions/show_sample', to: 'subscriptions#show_sample', as: :show_sample_subscriptions
  get 'subscriptions/shop_case', to: 'subscriptions#shop_case', as: :shop_case#ショップ事例

  get 'user/:id/ticket', to: 'users#ticket', as: :use_ticket #チケット発行ページ

  get '/subscriptions/:subscription_id/subscription_reviews', to: 'reviews#subscription_reviews', as: :subscription_reviews #サブスクレビューページ

  get '/ticket_success', to: 'tickets#ticket_success', as: :ticket_success
  patch 'users/:user_id/tickets/:id/ticket_update_after_second_time', to: 'tickets#ticket_update_after_second_time', as: :ticket_update_after_second_time

  devise_for :admins, controllers: {
    sessions:      'admins/sessions',
    passwords:     'admins/passwords',
    registrations: 'admins/registrations'
  }
  devise_for :owners, path: 'owners', controllers: {
    sessions:      'owners/sessions',
    passwords:     'owners/passwords',
    registrations: 'owners/registrations'
  }
  devise_scope :owner do
    get "/devise/auth/facebook_owner/callback" => "owners/omniauth_callbacks#facebook_owner"
    get "/devise/auth/twitter_owner/callback" => "owners/omniauth_callbacks#twitter_owner"
    get "/devise/auth/line_owner/callback" => "owners/omniauth_callbacks#line_owner"
  end

  devise_for :users, path: 'users', controllers: {
   # omniauth_callbacks:  'users/omniauth_callbacks',
    sessions:      'users/sessions',
    passwords:     'users/passwords',
    registrations: 'users/registrations'
  }
  devise_scope :user do
    post 'users/sign_up/confirm', to: 'users/registrations#confirm'
    patch 'users/sign_up/complete', to: 'users/registrations#complete'
    post 'users/sign_up/complete', to: 'users/registrations#complete'
    get "/devise/auth/facebook/callback" => "users/omniauth_callbacks#facebook"
    get "/devise/auth/twitter/callback" => "users/omniauth_callbacks#twitter"
    get "/devise/auth/line/callback" => "users/omniauth_callbacks#line"
    get 'users/sign_up', to: 'users#new'
  end

  devise_scope :owner do
    post 'owners/sign_up/confirm', to: 'owners/registrations#confirm'
    patch 'owners/sign_up/complete', to: 'owners/registrations#complete'
    post 'owners/sign_up/complete', to: 'owners/registrations#complete'
  end

  resources :admins do
      get 'admin_account', on: :member#アカウントページ
  end
  resources :blogs#管理者が書くサブスクnews
  get 'reviews/list' => "reviews#list"#利用者ではない人用の表示ページ
  get 'subscriptions/list' => "subscriptions#list"#まだ決まってない。使わないかもしれない
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
        resources :subscriptions do
          resources :images
        end
  end
  resources :maps
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
      get 'okonomiyaki', on: :collection
      get 'nabe', on: :collection
      get 'sweets', on: :collection
      get 'karaage', on: :collection
      get 'gyouza', on: :collection
      get 'don', on: :collection
      get 'udon', on: :collection
      get 'soba', on: :collection
      get 'other', on: :collection
  end
  get 'users/deleted_users'##論理削除された利用者
  resources :users do
    resources :tickets#サブスクチケット
    resources :reviews#利用者レビュー
      get "thanks", on: :member#会員完了通知仮面
      get 'user_account', on: :member#アカウントページ
      patch 'update_deleted_users', on: :member#アカウントページ論理削除
  end
  resources :shops, only: :new
  resources :questions#よくある質問
  post 'questions/:id/edit', to: 'questions#edit', as: :edit_questions #よくある質問編集
  resources :megurumereviews

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
